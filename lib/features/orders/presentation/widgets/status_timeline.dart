import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/order.dart';

enum _StepState { done, active, failed }

/// Created → Hold requested → Hold placed (or declined), built from the
/// order's server-side timeline events.
class StatusTimeline extends StatelessWidget {
  const StatusTimeline({super.key, required this.order});

  final CustomerOrder order;

  @override
  Widget build(BuildContext context) {
    DateTime? at(TimelineEventType type) => order.timeline.where((e) => e.type == type).firstOrNull?.at;

    final steps = <(String, String?, _StepState)>[
      ('Order created', _time(at(TimelineEventType.orderCreated)), _StepState.done),
      ('Payment hold requested', _time(at(TimelineEventType.holdRequested)), _StepState.done),
      switch (order.hold.status) {
        HoldStatus.pending => (
          'Waiting for your bank to confirm the hold…',
          'Usually a few seconds',
          _StepState.active,
        ),
        HoldStatus.placed => (
          'Hold placed. Booking confirmed',
          _time(at(TimelineEventType.holdPlaced)),
          _StepState.done,
        ),
        HoldStatus.failed => ('Hold declined by your bank', _time(at(TimelineEventType.holdFailed)), _StepState.failed),
      },
    ];

    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          _TimelineStep(
            key: Key('timeline.step.$i'),
            title: steps[i].$1,
            subtitle: steps[i].$2,
            state: steps[i].$3,
            isLast: i == steps.length - 1,
          ),
      ],
    );
  }

  static String? _time(DateTime? at) => at == null ? null : formatTimestamp(at);
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.state,
    required this.isLast,
  });

  final String title;
  final String? subtitle;
  final _StepState state;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final node = switch (state) {
      _StepState.done => const _Node(
        color: RefreshiColors.forest,
        child: Icon(Icons.check_rounded, size: 16, color: RefreshiColors.lime),
      ),
      _StepState.failed => const _Node(
        color: RefreshiColors.orange,
        child: Icon(Icons.close_rounded, size: 16, color: RefreshiColors.forest),
      ),
      _StepState.active => const _Node(
        color: RefreshiColors.lime,
        child: Padding(
          padding: EdgeInsets.all(6),
          child: CircularProgressIndicator(strokeWidth: 2, color: RefreshiColors.forest),
        ),
      ),
    };
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              node,
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: RefreshiColors.forest.withValues(alpha: 0.25),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4, bottom: isLast ? 0 : 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  if (subtitle case final subtitle?)
                    Text(subtitle, style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Node extends StatelessWidget {
  const _Node({required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: 28,
    height: 28,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    alignment: Alignment.center,
    child: child,
  );
}
