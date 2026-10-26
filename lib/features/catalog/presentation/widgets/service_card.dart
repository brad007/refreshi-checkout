import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/money_formatter.dart';
import '../../../../core/widgets/brand.dart';
import '../../domain/entities/catalog_service.dart';

/// A rescue bag, laid out like a price tag: the store, what's inside, and the
/// saving. Selected bags flip to forest with a lime check.
class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.service,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final CatalogService service;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ink = selected ? RefreshiColors.creamLight : scheme.onSurface;
    final muted = selected ? RefreshiColors.creamLight.withValues(alpha: 0.7) : scheme.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: selected,
      enabled: enabled,
      label:
          '${service.name} from ${service.storeName}, ${formatMoney(service.priceCents)}, '
          '${service.savingsPercent}% off',
      excludeSemantics: true,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: enabled ? 1 : 0.45,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: selected ? RefreshiColors.forest : scheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: selected ? RefreshiColors.forest : scheme.outlineVariant),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: enabled ? onTap : null,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 18, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _CategoryMark(category: service.category, selected: selected),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            service.storeName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: muted, fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                        ),
                        PillBadge(
                          '-${service.savingsPercent}%',
                          background: RefreshiColors.lime,
                          foreground: RefreshiColors.forest,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(service.name, style: displayStyle(23, color: ink)),
                    const SizedBox(height: 6),
                    Text(
                      service.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: muted, fontSize: 14, height: 1.35),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formatMoney(service.priceCents),
                                style: displayStyle(
                                  26,
                                  color: selected ? RefreshiColors.lime : RefreshiColors.orangeInk,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    formatMoney(service.originalPriceCents),
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: TextStyle(
                                      color: muted,
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: muted,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        _AddButton(selected: selected),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryMark extends StatelessWidget {
  const _CategoryMark({required this.category, required this.selected});

  final String category;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? RefreshiColors.forestRaised : RefreshiColors.cream,
      ),
      child: Icon(categoryIcon(category), size: 18, color: selected ? RefreshiColors.lime : RefreshiColors.forest),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutBack,
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: selected ? 14 : 16),
      decoration: BoxDecoration(
        color: selected ? RefreshiColors.lime : RefreshiColors.forest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            selected ? Icons.check_rounded : Icons.add_rounded,
            size: 18,
            color: selected ? RefreshiColors.forest : RefreshiColors.lime,
          ),
          const SizedBox(width: 6),
          Text(
            selected ? 'Added' : 'Add',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: selected ? RefreshiColors.forest : RefreshiColors.lime,
            ),
          ),
        ],
      ),
    );
  }
}
