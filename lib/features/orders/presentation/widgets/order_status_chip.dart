import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/brand.dart';
import '../../domain/entities/order.dart';

/// Status pill, designed to sit on the forest order hero.
class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, background, icon) = switch (status) {
      OrderStatus.awaitingHold => ('Pending', RefreshiColors.creamLight, Icons.hourglass_top_rounded),
      OrderStatus.confirmed => ('Confirmed', RefreshiColors.lime, Icons.check_rounded),
      OrderStatus.paymentFailed => ('Payment failed', RefreshiColors.orange, Icons.close_rounded),
    };
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: PillBadge(
        label,
        key: ValueKey(status),
        background: background,
        foreground: RefreshiColors.forest,
        icon: icon,
      ),
    );
  }
}
