import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_router.gr.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/money_formatter.dart';
import '../../../../core/widgets/app_shell.dart';
import '../../../../core/widgets/brand.dart';
import '../../../../core/widgets/failure_view.dart';
import '../../../checkout/domain/entities/checkout_draft.dart';
import '../../../checkout/presentation/bloc/checkout_bloc.dart';
import '../../domain/entities/checkout_catalog.dart';
import '../bloc/catalog_bloc.dart';
import '../widgets/service_card.dart';

@RoutePage()
class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  void initState() {
    super.initState();
    context.read<CatalogBloc>().add(const CatalogEvent.requested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, catalogState) => AppShell(
        title: 'Rescue food',
        bottomBar: switch (catalogState) {
          // Fixed chrome: cap text scaling so the dock can't overflow.
          CatalogLoaded(:final catalog) => MediaQuery.withClampedTextScaling(
            maxScaleFactor: 1.3,
            child: _SelectionBar(catalog: catalog),
          ),
          _ => null,
        },
        body: switch (catalogState) {
          CatalogInitial() || CatalogLoading() => const _CatalogSkeleton(),
          CatalogFailure(:final failure) => FailureView(
            failure: failure,
            onRetry: () => context.read<CatalogBloc>().add(const CatalogEvent.requested(forceRefresh: true)),
          ),
          CatalogLoaded(:final catalog) => _ServiceList(catalog: catalog),
        },
      ),
    );
  }
}

class _ServiceList extends StatelessWidget {
  const _ServiceList({required this.catalog});

  final CheckoutCatalog catalog;

  @override
  Widget build(BuildContext context) {
    final draft = context.select((CheckoutBloc bloc) => bloc.state.draft);
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < AppShell.compactBreakpoint;
    final bestSaving = catalog.services.fold<int>(0, (best, s) => s.savingsPercent > best ? s.savingsPercent : best);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          sliver: SliverToBoxAdapter(
            child: EntranceTransition(
              index: 0,
              child: ForestPanel(
                padding: EdgeInsets.fromLTRB(compact ? 24 : 40, compact ? 24 : 32, 24, compact ? 24 : 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PillBadge(
                      'Up to $bestSaving% off today',
                      background: RefreshiColors.orange,
                      foreground: RefreshiColors.forest,
                      icon: Icons.local_fire_department_rounded,
                    ),
                    const SizedBox(height: 20),
                    StackedHeadline(
                      size: compact ? 40 : 54,
                      lines: const [
                        ('Rescue food.', RefreshiColors.creamLight),
                        ('Pay less.', RefreshiColors.orange),
                        ('Waste nothing.', RefreshiColors.lime),
                      ],
                    ),
                    const SizedBox(height: 18),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Text(
                        'Today\'s surplus from stores near you. Choose up to ${CheckoutDraft.maxServices} '
                        'bags and collect them in your pickup window.',
                        style: TextStyle(
                          color: RefreshiColors.creamLight.withValues(alpha: 0.8),
                          fontSize: compact ? 15 : 17,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
          sliver: SliverToBoxAdapter(
            // Wraps so the limit hint drops below the title on narrow phones.
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                Text('Available now', style: displayStyle(26)),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  // Explain why the other bags are greyed out once the limit is hit.
                  child: draft != null && !draft.canAddMoreServices
                      ? const PillBadge(
                          key: ValueKey('limit'),
                          'Limit reached · tap a bag to swap',
                          background: RefreshiColors.orange,
                          foreground: RefreshiColors.forest,
                        )
                      : Text(
                          '${catalog.services.length} bags',
                          key: const ValueKey('count'),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 120),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: compact ? 1 : 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: 196,
            ),
            itemCount: catalog.services.length,
            itemBuilder: (context, index) {
              final service = catalog.services[index];
              final selected = draft?.serviceIds.contains(service.id) ?? false;
              return EntranceTransition(
                index: index + 1,
                child: ServiceCard(
                  key: Key('service.${service.id}'),
                  service: service,
                  selected: selected,
                  enabled: draft != null && (selected || draft.canAddMoreServices),
                  onTap: () => context.read<CheckoutBloc>().add(CheckoutEvent.serviceToggled(service.id)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Floating forest dock: what's picked, what it saves, and the way forward.
class _SelectionBar extends StatelessWidget {
  const _SelectionBar({required this.catalog});

  final CheckoutCatalog catalog;

  @override
  Widget build(BuildContext context) {
    final serviceIds = context.select((CheckoutBloc bloc) => bloc.state.draft?.serviceIds ?? const []);
    final services = [for (final id in serviceIds) ?catalog.serviceById(id)];
    final total = services.fold<int>(0, (sum, s) => sum + s.priceCents);
    final saved = services.fold<int>(0, (sum, s) => sum + s.savingsCents);
    final compact = MediaQuery.sizeOf(context).width < AppShell.compactBreakpoint;
    final cream = RefreshiColors.creamLight;

    return SafeArea(
      top: false,
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: RefreshiColors.forest,
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: RefreshiColors.forest.withValues(alpha: 0.28),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: serviceIds.isEmpty ? RefreshiColors.forestRaised : RefreshiColors.lime,
                    ),
                    child: Text(
                      '${serviceIds.length}',
                      style: displayStyle(
                        20,
                        color: serviceIds.isEmpty ? cream.withValues(alpha: 0.6) : RefreshiColors.forest,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: serviceIds.isEmpty
                        ? Text(
                            'No bags selected',
                            style: TextStyle(color: cream.withValues(alpha: 0.75), fontWeight: FontWeight.w600),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatMoney(total),
                                key: const Key('catalog.total'),
                                style: displayStyle(20, color: cream),
                              ),
                              Text(
                                'You save ${formatMoney(saved)}',
                                style: const TextStyle(
                                  color: RefreshiColors.lime,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                  ),
                  FilledButton(
                    key: const Key('catalog.continue'),
                    style: FilledButton.styleFrom(
                      backgroundColor: RefreshiColors.lime,
                      foregroundColor: RefreshiColors.forest,
                      disabledBackgroundColor: RefreshiColors.forestRaised,
                      disabledForegroundColor: cream.withValues(alpha: 0.4),
                      minimumSize: const Size(0, 48),
                      padding: EdgeInsets.symmetric(horizontal: compact ? 18 : 24),
                    ),
                    onPressed: serviceIds.isEmpty ? null : () => context.router.push(const CheckoutRoute()),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(compact ? 'Checkout' : 'Continue to checkout'),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_rounded, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Placeholder in the shape of the real page, so loading doesn't jump.
class _CatalogSkeleton extends StatelessWidget {
  const _CatalogSkeleton();

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < AppShell.compactBreakpoint;
    final block = Theme.of(context).colorScheme.surfaceContainerHigh;
    Widget box(double height, {double radius = 24}) => Container(
      height: height,
      decoration: BoxDecoration(color: block, borderRadius: BorderRadius.circular(radius)),
    );
    return Semantics(
      label: 'Loading today\'s bags',
      child: ExcludeSemantics(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          children: [
            Container(
              height: compact ? 300 : 280,
              decoration: BoxDecoration(color: RefreshiColors.forest, borderRadius: BorderRadius.circular(28)),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(width: 180, child: box(26, radius: 8)),
              ),
            ),
            const SizedBox(height: 16),
            for (var row = 0; row < 2; row++) ...[
              Row(
                children: [
                  Expanded(child: box(196)),
                  if (!compact) ...[const SizedBox(width: 12), Expanded(child: box(196))],
                ],
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
