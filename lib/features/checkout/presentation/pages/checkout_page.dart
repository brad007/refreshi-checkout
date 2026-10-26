import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../../core/utils/money_formatter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_shell.dart';
import '../../../../core/widgets/brand.dart';
import '../../../../core/widgets/failure_view.dart';
import '../../../catalog/domain/entities/checkout_catalog.dart';
import '../../../catalog/presentation/bloc/catalog_bloc.dart';
import '../../../orders/domain/entities/order_placement.dart';
import '../../domain/entities/checkout_draft.dart';
import '../bloc/checkout_bloc.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/payment_method_picker.dart';
import '../widgets/slot_picker.dart';

@RoutePage()
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  OrderPlacement? _handled;

  @override
  void initState() {
    super.initState();
    final catalogBloc = context.read<CatalogBloc>();
    if (catalogBloc.state case CatalogLoaded(:final catalog)) {
      context.read<CheckoutBloc>().add(CheckoutEvent.catalogAvailable(catalog));
    } else {
      catalogBloc.add(const CatalogEvent.requested());
    }
    // A submission resumed at startup may have finished before this page
    // mounted, in which case the listener below never sees it change.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _onCheckoutChanged(context, context.read<CheckoutBloc>().state);
    });
  }

  void _onCheckoutChanged(BuildContext context, CheckoutState state) {
    final placement = state.placement;
    if (state.status != CheckoutStatus.success || placement == null) return;
    if (identical(placement, _handled)) return;
    // Hold a spinner while the order route slides in: the basket is about to
    // reset, and the empty state must not flash on the way out.
    setState(() => _handled = placement);
    final message = switch ((placement.replayed, state.resumed)) {
      (true, _) => 'We found the order you already placed. You haven\'t been charged twice.',
      (false, true) => 'Your order was completed after the page reloaded.',
      (false, false) => null,
    };
    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
    context.read<CheckoutBloc>().add(const CheckoutEvent.placementHandled());
    // Replace, so browser/app back doesn't return to a spent checkout.
    context.router.replace(OrderDetailsRoute(orderId: placement.order.id));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CatalogBloc, CatalogState>(
          listener: (context, state) {
            if (state case CatalogLoaded(:final catalog)) {
              context.read<CheckoutBloc>().add(CheckoutEvent.catalogAvailable(catalog));
            }
          },
        ),
        BlocListener<CheckoutBloc, CheckoutState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: _onCheckoutChanged,
        ),
      ],
      child: AppShell(
        title: 'Checkout',
        bottomBar: MediaQuery.sizeOf(context).width < AppShell.compactBreakpoint
            ? MediaQuery.withClampedTextScaling(maxScaleFactor: 1.3, child: const _MobileActionBar())
            : null,
        body: BlocBuilder<CatalogBloc, CatalogState>(
          builder: (context, catalogState) => switch (catalogState) {
            CatalogInitial() || CatalogLoading() => const Center(child: CircularProgressIndicator()),
            CatalogFailure(:final failure) => FailureView(
              failure: failure,
              onRetry: () => context.read<CatalogBloc>().add(const CatalogEvent.requested(forceRefresh: true)),
            ),
            CatalogLoaded() when _handled != null => const Center(child: CircularProgressIndicator()),
            CatalogLoaded(:final catalog) => _CheckoutBody(catalog: catalog),
          },
        ),
      ),
    );
  }
}

class _CheckoutBody extends StatelessWidget {
  const _CheckoutBody({required this.catalog});

  final CheckoutCatalog catalog;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        final draft = state.draft;
        if (draft == null || state.status == CheckoutStatus.success) {
          return const Center(child: CircularProgressIndicator());
        }
        if (draft.isEmpty) return const _EmptyCheckout();

        final bloc = context.read<CheckoutBloc>();
        final editable = !state.isSubmitting;
        final services = [for (final id in draft.serviceIds) ?catalog.serviceById(id)];
        final compact = MediaQuery.sizeOf(context).width < AppShell.compactBreakpoint;

        final options = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BackLink(label: 'Back to bags', onPressed: () => context.router.navigate(const CatalogRoute())),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 20),
              child: StackedHeadline(
                size: compact ? 36 : 48,
                lines: [
                  ('Almost yours.', Theme.of(context).colorScheme.onSurface),
                  ('Two quick steps.', RefreshiColors.orangeInk),
                ],
              ),
            ),
            if (state.failure case final failure?) ...[_FailureBanner(failure: failure), const SizedBox(height: 16)],
            if (state.resumed && state.isSubmitting) ...[const _ResumingBanner(), const SizedBox(height: 16)],
            EntranceTransition(
              index: 1,
              child: _Section(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StepHeading(number: 1, title: 'Pickup window', subtitle: 'When will you collect?'),
                    const SizedBox(height: 20),
                    SlotPicker(
                      slots: catalog.slots,
                      selectedSlotId: draft.slotId,
                      enabled: editable,
                      onSelected: (id) => bloc.add(CheckoutEvent.slotSelected(id)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            EntranceTransition(
              index: 2,
              child: _Section(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StepHeading(number: 2, title: 'Pay with', subtitle: 'Choose a saved card.'),
                    const SizedBox(height: 20),
                    PaymentMethodPicker(
                      methods: catalog.paymentMethods,
                      selectedId: draft.paymentMethodId,
                      enabled: editable,
                      onSelected: (id) => bloc.add(CheckoutEvent.paymentMethodSelected(id)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
        final summary = EntranceTransition(
          index: 3,
          child: OrderSummaryCard(
            services: services,
            slot: catalog.slotById(draft.slotId),
            canSubmit: state.canSubmit,
            isSubmitting: state.isSubmitting,
            onConfirm: () => bloc.add(const CheckoutEvent.submitted()),
            hint: state.isSpent ? 'Use the options above to continue.' : missingStepHint(draft),
            showAction: !compact,
          ),
        );

        if (compact) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
            children: [options, const SizedBox(height: 12), summary],
          );
        }
        // The options scroll; the receipt and its button stay in view.
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(16, 0, 8, 40), child: options),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(8, 52, 16, 40), child: summary),
            ),
          ],
        );
      },
    );
  }
}

/// Tells the customer what's left to do while the order can't be placed yet.
String? missingStepHint(CheckoutDraft draft) => switch ((draft.slotId == null, draft.paymentMethodId == null)) {
  (true, true) => 'Choose a pickup window and a card to continue.',
  (true, false) => 'Choose a pickup window to continue.',
  (false, true) => 'Choose a card to continue.',
  (false, false) => null,
};

/// On phones the primary action sits in a sticky bar, always within reach.
class _MobileActionBar extends StatelessWidget {
  const _MobileActionBar();

  @override
  Widget build(BuildContext context) {
    final catalog = switch (context.watch<CatalogBloc>().state) {
      CatalogLoaded(:final catalog) => catalog,
      _ => null,
    };
    final state = context.watch<CheckoutBloc>().state;
    final draft = state.draft;
    if (catalog == null || draft == null || draft.isEmpty || state.status == CheckoutStatus.success) {
      return const SizedBox.shrink();
    }
    final total = draft.serviceIds.fold<int>(0, (sum, id) => sum + (catalog.serviceById(id)?.priceCents ?? 0));
    final hint = missingStepHint(draft);

    return Material(
      color: Theme.of(context).colorScheme.surface,
      elevation: 12,
      shadowColor: RefreshiColors.forest.withValues(alpha: 0.3),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hint != null && !state.isSubmitting) ...[
                Text(
                  hint,
                  style: const TextStyle(color: RefreshiColors.orangeInk, fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const SizedBox(height: 8),
              ],
              Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12),
                      ),
                      Text(formatMoney(total), style: displayStyle(24)),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ConfirmHoldButton(
                      canSubmit: state.canSubmit,
                      isSubmitting: state.isSubmitting,
                      onConfirm: () => context.read<CheckoutBloc>().add(const CheckoutEvent.submitted()),
                      label: 'Reserve & hold',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(padding: const EdgeInsets.all(24), child: child),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({super.key, required this.icon, required this.message, this.actions = const [], this.tone});

  final IconData icon;
  final String message;
  final List<Widget> actions;
  final Color? tone;

  @override
  Widget build(BuildContext context) {
    final bg = tone ?? RefreshiColors.orange;
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 12, 14),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: RefreshiColors.forest, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: RefreshiColors.forest, fontWeight: FontWeight.w600, height: 1.35),
                ),
              ),
            ],
          ),
          if (actions.isNotEmpty) ...[const SizedBox(height: 8), Wrap(spacing: 8, children: actions)],
        ],
      ),
    );
  }
}

class _FailureBanner extends StatelessWidget {
  const _FailureBanner({required this.failure});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    final existingOrderId = switch (failure) {
      IdempotencyConflictFailure(:final existingOrderId) => existingOrderId,
      _ => null,
    };
    final actionStyle = TextButton.styleFrom(
      foregroundColor: RefreshiColors.forest,
      backgroundColor: RefreshiColors.creamLight.withValues(alpha: 0.55),
    );
    return _Banner(
      key: const Key('checkout.failure'),
      icon: Icons.error_outline_rounded,
      message: failure.userMessage,
      actions: [
        if (failure is IdempotencyConflictFailure) ...[
          if (existingOrderId != null)
            TextButton(
              style: actionStyle,
              onPressed: () => context.router.replace(OrderDetailsRoute(orderId: existingOrderId)),
              child: const Text('View that order'),
            ),
          TextButton(
            style: actionStyle,
            onPressed: () => context.read<CheckoutBloc>().add(const CheckoutEvent.newCheckoutRequested()),
            child: const Text('Start a new checkout'),
          ),
        ],
      ],
    );
  }
}

class _ResumingBanner extends StatelessWidget {
  const _ResumingBanner();

  @override
  Widget build(BuildContext context) {
    return const _Banner(
      icon: Icons.sync_rounded,
      tone: RefreshiColors.lime,
      message: 'Picking up where you left off. Finishing your order…',
    );
  }
}

class _EmptyCheckout extends StatelessWidget {
  const _EmptyCheckout();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.shopping_bag_outlined, size: 48, color: RefreshiColors.orangeInk),
            const SizedBox(height: 16),
            Text('Your bag is empty', style: displayStyle(30)),
            const SizedBox(height: 8),
            Text(
              'Pick something to rescue first.',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.router.navigate(const CatalogRoute()),
              child: const Text('See today\'s bags'),
            ),
          ],
        ),
      ),
    );
  }
}
