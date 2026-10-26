import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/brand.dart';
import '../../../catalog/domain/entities/payment_method.dart';

/// Saved cards drawn as cards, plus a note on how Peach Payments is used.
class PaymentMethodPicker extends StatelessWidget {
  const PaymentMethodPicker({
    super.key,
    required this.methods,
    required this.selectedId,
    required this.onSelected,
    this.enabled = true,
  });

  final List<PaymentMethod> methods;
  final String? selectedId;
  final ValueChanged<String> onSelected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            // Two cards per row on phones, up to 176px wide on larger screens.
            final width = ((constraints.maxWidth - 12) / 2).clamp(120.0, 176.0);
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final (i, method) in methods.indexed)
                  _SavedCard(
                    key: Key('paymentMethod.${method.id}'),
                    method: method,
                    tone: i,
                    width: width,
                    selected: method.id == selectedId,
                    onTap: enabled ? () => onSelected(method.id) : null,
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lock_outline_rounded, size: 16, color: scheme.onSurfaceVariant),
            const SizedBox(width: 8),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13, height: 1.4),
                  children: const [
                    TextSpan(text: 'Cards are saved with '),
                    TextSpan(
                      text: 'Peach Payments',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: '. We place a temporary hold (pre-authorisation) now and only charge it at pickup.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SavedCard extends StatelessWidget {
  const _SavedCard({
    super.key,
    required this.method,
    required this.tone,
    required this.width,
    required this.selected,
    required this.onTap,
  });

  final PaymentMethod method;
  final int tone;
  final double width;
  final bool selected;
  final VoidCallback? onTap;

  static const _tones = [
    (RefreshiColors.forest, RefreshiColors.creamLight),
    (RefreshiColors.sage, RefreshiColors.forest),
    (RefreshiColors.orange, RefreshiColors.forest),
  ];

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = _tones[tone % _tones.length];
    return Semantics(
      button: true,
      selected: selected,
      label: method.label,
      excludeSemantics: true,
      // InkWell, not GestureDetector, so the card is reachable and selectable
      // with the keyboard (Tab, then Enter or Space) and shows a focus ring.
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(19),
          focusColor: RefreshiColors.lime.withValues(alpha: 0.45),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            width: width,
            // A minimum card-like height that still grows with larger text.
            constraints: BoxConstraints(minHeight: math.max(width * 0.62, 100)),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              border: Border.all(color: selected ? RefreshiColors.lime : Colors.transparent, width: 3),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: RefreshiColors.forest.withValues(alpha: 0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : const [],
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
              decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        // Scales down rather than truncating on narrow cards.
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            method.brand,
                            maxLines: 1,
                            style: displayStyle(16, color: fg, weight: FontWeight.w600),
                          ),
                        ),
                      ),
                      AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: selected ? 1 : 0,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: RefreshiColors.lime),
                          child: const Icon(Icons.check_rounded, size: 16, color: RefreshiColors.forest),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '•••• ${method.last4}',
                    style: TextStyle(
                      color: fg,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 1.5,
                      fontFeatures: const [FontFeature.tabularFigures()],
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
