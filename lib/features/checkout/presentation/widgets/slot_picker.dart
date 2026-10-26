import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/brand.dart';
import '../../../catalog/domain/entities/time_slot.dart';

/// Date tiles, then the pickup windows on the chosen day. Which day is
/// showing is purely visual, so it is widget state, not bloc state.
class SlotPicker extends StatefulWidget {
  const SlotPicker({
    super.key,
    required this.slots,
    required this.selectedSlotId,
    required this.onSelected,
    this.enabled = true,
  });

  final List<TimeSlot> slots;
  final String? selectedSlotId;
  final ValueChanged<String> onSelected;
  final bool enabled;

  @override
  State<SlotPicker> createState() => _SlotPickerState();
}

class _SlotPickerState extends State<SlotPicker> {
  DateTime? _day;

  List<DateTime> get _days => {for (final slot in widget.slots) slot.day}.toList()..sort();

  DateTime? get _visibleDay {
    if (_day != null) return _day;
    final selected = widget.slots.where((s) => s.id == widget.selectedSlotId).firstOrNull;
    return selected?.day ?? _days.firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.slots.isEmpty) {
      return const Text('No pickup windows are open right now. Please check back later.');
    }
    final day = _visibleDay;
    final times = widget.slots.where((s) => s.day == day).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final days = _days;
            const gap = 8.0;
            // Tiles grow with the user's text size, capped so they stay tiles.
            final height = 88 * MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 1.4).scale(1);
            Widget tile(int i, double width) => MediaQuery.withClampedTextScaling(
              maxScaleFactor: 1.4,
              child: _DayTile(
                key: Key('day.${DateFormat('yyyy-MM-dd').format(days[i])}'),
                day: days[i],
                width: width,
                selected: days[i] == day,
                onTap: widget.enabled ? () => setState(() => _day = days[i]) : null,
              ),
            );
            // Fit every day on one row when there's room for 52px tiles…
            final fitted = (constraints.maxWidth - gap * (days.length - 1)) / days.length;
            if (fitted >= 52) {
              return SizedBox(
                height: height,
                child: Row(
                  children: [
                    for (var i = 0; i < days.length; i++) ...[
                      if (i > 0) const SizedBox(width: gap),
                      Expanded(child: tile(i, fitted.clamp(52, 68))),
                    ],
                  ],
                ),
              );
            }
            // …otherwise scroll, draggable with a mouse too, fading out at
            // the edge to show there's more.
            return SizedBox(
              height: height,
              child: ShaderMask(
                shaderCallback: (rect) => const LinearGradient(
                  colors: [Colors.black, Colors.black, Colors.transparent],
                  stops: [0, 0.85, 1],
                ).createShader(rect),
                blendMode: BlendMode.dstIn,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(dragDevices: PointerDeviceKind.values.toSet()),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: days.length,
                    padding: const EdgeInsets.only(right: 24),
                    separatorBuilder: (_, _) => const SizedBox(width: gap),
                    itemBuilder: (context, i) => tile(i, 68),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final slot in times)
              _TimePill(
                key: Key('slot.${slot.id}'),
                label: formatSlotTime(slot.startsAt, slot.endsAt),
                selected: slot.id == widget.selectedSlotId,
                onTap: widget.enabled ? () => widget.onSelected(slot.id) : null,
              ),
          ],
        ),
      ],
    );
  }
}

class _DayTile extends StatelessWidget {
  const _DayTile({super.key, required this.day, required this.width, required this.selected, required this.onTap});

  final DateTime day;
  final double width;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = selected ? RefreshiColors.lime : scheme.onSurface;
    final sub = selected ? RefreshiColors.creamLight.withValues(alpha: 0.75) : scheme.onSurfaceVariant;
    return Semantics(
      button: true,
      selected: selected,
      label: formatSlotDay(day),
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: width,
          decoration: BoxDecoration(
            color: selected ? RefreshiColors.forest : scheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: selected ? RefreshiColors.forest : scheme.outlineVariant),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('EEE').format(day).toUpperCase(),
                style: TextStyle(color: sub, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2),
              ),
              const SizedBox(height: 2),
              Text('${day.day}', style: displayStyle(28, color: fg)),
              Text(DateFormat('MMM').format(day), style: TextStyle(color: sub, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimePill extends StatelessWidget {
  const _TimePill({super.key, required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width < 420 ? 12 : 18, vertical: 12),
          decoration: BoxDecoration(
            color: selected ? RefreshiColors.lime : scheme.surface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: selected ? RefreshiColors.forest : scheme.outlineVariant,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.schedule_rounded, size: 16, color: selected ? RefreshiColors.forest : scheme.onSurfaceVariant),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: selected ? RefreshiColors.forest : scheme.onSurface,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
