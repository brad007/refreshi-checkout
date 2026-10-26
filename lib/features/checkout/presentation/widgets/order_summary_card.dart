import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/money_formatter.dart';
import '../../../../core/widgets/brand.dart';
import '../../../catalog/domain/entities/catalog_service.dart';
import '../../../catalog/domain/entities/time_slot.dart';

/// The order summary as a till receipt: line items, the saving, the total,
/// and the confirm button.
class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    required this.services,
    required this.slot,
    required this.canSubmit,
    required this.isSubmitting,
    required this.onConfirm,
    this.hint,
    this.showAction = true,
  });

  final List<CatalogService> services;
  final TimeSlot? slot;
  final bool canSubmit;
  final bool isSubmitting;
  final VoidCallback onConfirm;

  /// What's still missing before the order can be placed, if anything.
  final String? hint;

  /// False on phones, where the action lives in a sticky bottom bar instead.
  final bool showAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final total = services.fold<int>(0, (sum, s) => sum + s.priceCents);
    final saved = services.fold<int>(0, (sum, s) => sum + s.savingsCents);
    final slot = this.slot;
    final muted = TextStyle(color: scheme.onSurfaceVariant, fontSize: 13);

    return ClipPath(
      clipper: const ReceiptClipper(),
      child: ColoredBox(
        color: scheme.surface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(child: Text('Your bags', style: displayStyle(24))),
                  Text('${services.length} of 2', style: muted),
                ],
              ),
              const SizedBox(height: 16),
              for (final service in services)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(service.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                            Text(service.storeName, style: muted),
                          ],
                        ),
                      ),
                      Text(formatMoney(service.priceCents), style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              const DashedDivider(),
              _Line(
                label: 'Pickup',
                value: slot == null
                    ? 'Choose a window'
                    : '${formatSlotDay(slot.startsAt)}, ${formatSlotTime(slot.startsAt, slot.endsAt)}',
                muted: slot == null,
              ),
              const SizedBox(height: 6),
              _Line(label: 'You save', value: formatMoney(saved), valueColor: RefreshiColors.orangeInk),
              const DashedDivider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Total', style: displayStyle(20)),
                  const SizedBox(width: 12),
                  Expanded(
                    // Scales down rather than overflowing with large text.
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(formatMoney(total), key: const Key('summary.total'), style: displayStyle(34)),
                    ),
                  ),
                ],
              ),
              if (showAction) ...[
                const SizedBox(height: 20),
                ConfirmHoldButton(canSubmit: canSubmit, isSubmitting: isSubmitting, onConfirm: onConfirm),
                if (hint != null && !isSubmitting) ...[
                  const SizedBox(height: 10),
                  Text(
                    hint!,
                    key: const Key('summary.hint'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: RefreshiColors.orangeInk, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ],
              ],
              const SizedBox(height: 10),
              Text(
                'Secured by Peach Payments · Hold released if you don\'t collect',
                textAlign: TextAlign.center,
                style: muted.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value, this.valueColor, this.muted = false});

  final String label;
  final String value;
  final Color? valueColor;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text(label, style: TextStyle(color: scheme.onSurfaceVariant)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: muted ? scheme.onSurfaceVariant : (valueColor ?? scheme.onSurface),
            ),
          ),
        ),
      ],
    );
  }
}

/// The primary action: places the order and the Peach pre-authorisation.
class ConfirmHoldButton extends StatelessWidget {
  const ConfirmHoldButton({
    super.key,
    required this.canSubmit,
    required this.isSubmitting,
    required this.onConfirm,
    this.label = 'Reserve & place hold',
  });

  final bool canSubmit;
  final bool isSubmitting;
  final VoidCallback onConfirm;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      key: const Key('checkout.confirm'),
      // Stay forest while submitting so the spinner reads as progress.
      style: isSubmitting ? FilledButton.styleFrom(disabledBackgroundColor: RefreshiColors.forest) : null,
      // Disabled while submitting; the bloc also drops repeat events.
      onPressed: canSubmit ? onConfirm : null,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child: isSubmitting
            ? const SizedBox.square(
                dimension: 22,
                child: CircularProgressIndicator(strokeWidth: 2.5, color: RefreshiColors.lime),
              )
            : Text(label),
      ),
    );
  }
}
