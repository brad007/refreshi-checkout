import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/money_formatter.dart';
import '../../../../core/widgets/app_shell.dart';
import '../../../../core/widgets/brand.dart';
import '../../../../core/widgets/failure_view.dart';
import '../../../checkout/presentation/bloc/checkout_bloc.dart';
import '../../domain/entities/order.dart';
import '../bloc/order_details_bloc.dart';
import '../widgets/order_status_chip.dart';
import '../widgets/status_timeline.dart';

@RoutePage()
class OrderDetailsPage extends StatelessWidget implements AutoRouteWrapper {
  const OrderDetailsPage({super.key, @PathParam('orderId') required this.orderId});

  final String orderId;

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider(create: (_) => getIt<OrderDetailsBloc>()..add(OrderDetailsEvent.started(orderId)), child: this);

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Order $orderId',
      maxWidth: 1040,
      body: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
        builder: (context, state) => switch (state.status) {
          OrderDetailsStatus.loading => const Center(child: CircularProgressIndicator()),
          OrderDetailsStatus.failure => FailureView(
            failure: state.failure!,
            onRetry: () => context.read<OrderDetailsBloc>().add(OrderDetailsEvent.started(orderId)),
            // The primary action when retrying can't help (e.g. not found).
            action: state.failure is NotFoundFailure
                ? FilledButton(
                    onPressed: () => context.router.navigate(const CatalogRoute()),
                    child: const Text('See today\'s bags'),
                  )
                : OutlinedButton(
                    onPressed: () => context.router.navigate(const CatalogRoute()),
                    child: const Text('See today\'s bags'),
                  ),
          ),
          OrderDetailsStatus.loaded => _OrderDetails(order: state.order!, state: state),
        },
      ),
    );
  }
}

class _OrderDetails extends StatelessWidget {
  const _OrderDetails({required this.order, required this.state});

  final CustomerOrder order;
  final OrderDetailsState state;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < AppShell.compactBreakpoint;
    final cream = RefreshiColors.creamLight;
    final released = order.hold.status == HoldStatus.failed;
    final headline = switch (order.hold.status) {
      HoldStatus.pending => [
        ('Hold on.', cream),
        ('Confirming with', RefreshiColors.lime),
        ('your bank…', RefreshiColors.lime),
      ],
      HoldStatus.placed => [('Bags reserved.', RefreshiColors.lime), ('See you at pickup.', cream)],
      HoldStatus.failed => [('Payment declined.', RefreshiColors.orange), ('Your bags are released.', cream)],
    };

    final ticket = _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Eyebrow(released ? 'Pickup · not reserved' : 'Pickup'),
          const SizedBox(height: 6),
          Text(
            formatSlotTime(order.slot.startsAt, order.slot.endsAt),
            style: displayStyle(
              compact ? 34 : 40,
              color: released ? Theme.of(context).colorScheme.onSurfaceVariant : RefreshiColors.forest,
            ).copyWith(decoration: released ? TextDecoration.lineThrough : null),
          ),
          Text(
            formatSlotDay(order.slot.startsAt),
            style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const DashedDivider(height: 32),
          for (final item in order.items)
            _Row(
              label: item.name,
              value: formatMoney(item.priceCents, currency: order.currency),
            ),
          const DashedDivider(),
          Row(
            children: [
              Expanded(child: Text('Total', style: displayStyle(20))),
              Text(formatMoney(order.totalCents, currency: order.currency), style: displayStyle(28)),
            ],
          ),
        ],
      ),
    );

    final status = _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Eyebrow('Status'),
          const SizedBox(height: 16),
          StatusTimeline(order: order),
          if (state.liveUpdateFailure != null) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(child: Text('Live updates stopped.')),
                TextButton(
                  onPressed: () => context.read<OrderDetailsBloc>().add(OrderDetailsEvent.started(order.id)),
                  child: const Text('Refresh'),
                ),
              ],
            ),
          ],
        ],
      ),
    );

    final payment = _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(child: _Eyebrow('Payment')),
              PillBadge(
                'Peach Payments',
                background: RefreshiColors.cream,
                foreground: RefreshiColors.forest,
                icon: Icons.lock_outline_rounded,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _Row(label: 'Card', value: order.paymentMethod.label),
          _Row(
            label: order.hold.status == HoldStatus.placed ? 'Amount on hold' : 'Hold amount',
            value: formatMoney(order.hold.amountCents, currency: order.currency),
          ),
          _Row(
            label: 'Type',
            value: order.hold.paymentType == 'PA' ? 'Pre-authorisation (PA)' : order.hold.paymentType,
          ),
          if (order.hold.resultCode.isNotEmpty)
            _Row(label: 'Result', value: '${order.hold.resultCode} · ${order.hold.resultDescription}', small: true),
          if (order.hold.reference.isNotEmpty) _Row(label: 'Reference', value: order.hold.reference, small: true),
        ],
      ),
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 40),
      children: [
        EntranceTransition(
          index: 0,
          child: ForestPanel(
            padding: EdgeInsets.fromLTRB(compact ? 24 : 36, 28, 24, compact ? 28 : 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SelectableText(
                        'Order ${order.id}',
                        style: TextStyle(color: cream.withValues(alpha: 0.7), fontWeight: FontWeight.w600),
                      ),
                    ),
                    OrderStatusChip(key: const Key('order.status'), status: order.status),
                  ],
                ),
                const SizedBox(height: 18),
                // A live region, so screen readers announce when the bank
                // confirms or declines the hold.
                Semantics(
                  liveRegion: true,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: StackedHeadline(key: ValueKey(order.hold.status), size: compact ? 36 : 52, lines: headline),
                  ),
                ),
                if (released) ...[
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    key: const Key('order.retry'),
                    style: FilledButton.styleFrom(
                      backgroundColor: RefreshiColors.lime,
                      foregroundColor: RefreshiColors.forest,
                    ),
                    onPressed: () {
                      context.read<CheckoutBloc>().add(
                        CheckoutEvent.retryRequested(
                          serviceIds: [for (final item in order.items) item.serviceId],
                          slotId: order.slot.id,
                        ),
                      );
                      context.router.navigate(const CheckoutRoute());
                    },
                    icon: const Icon(Icons.credit_card_rounded),
                    label: const Text('Try another card'),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (compact) ...[
          EntranceTransition(index: 1, child: status),
          const SizedBox(height: 12),
          EntranceTransition(index: 2, child: ticket),
          const SizedBox(height: 12),
          EntranceTransition(index: 3, child: payment),
        ] else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    EntranceTransition(index: 1, child: status),
                    const SizedBox(height: 12),
                    EntranceTransition(index: 3, child: payment),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: EntranceTransition(index: 2, child: ticket)),
            ],
          ),
        const SizedBox(height: 24),
        Center(
          child: OutlinedButton(
            onPressed: () => context.router.navigate(const CatalogRoute()),
            child: const Text('Rescue more food'),
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: child,
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.6,
      color: RefreshiColors.orangeInk,
    ),
  );
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.small = false});

  final String label;
  final String value;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: scheme.onSurfaceVariant)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: small ? 12.5 : 15,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
