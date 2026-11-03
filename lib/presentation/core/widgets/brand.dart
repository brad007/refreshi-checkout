import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Display text in Clash Display, the brand's headline face.
TextStyle displayStyle(double size, {Color? color, FontWeight weight = FontWeight.w600, double height = 1.0}) =>
    TextStyle(
      fontFamily: RefreshiFonts.display,
      fontFamilyFallback: RefreshiFonts.fallback,
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: -0.02 * size,
      color: color,
    );

/// The brand's signature headline: short lines stacked tight, each in its
/// own colour ("Save Food. / Save Money. / Save the Planet.").
class StackedHeadline extends StatelessWidget {
  const StackedHeadline({super.key, required this.lines, this.size = 48, this.textAlign = TextAlign.start});

  final List<(String, Color)> lines;
  final double size;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      label: lines.map((l) => l.$1).join(' '),
      child: ExcludeSemantics(
        child: Text.rich(
          TextSpan(
            children: [
              for (var i = 0; i < lines.length; i++)
                TextSpan(
                  text: i == lines.length - 1 ? lines[i].$1 : '${lines[i].$1}\n',
                  style: displayStyle(size, color: lines[i].$2, height: 0.98),
                ),
            ],
          ),
          textAlign: textAlign,
        ),
      ),
    );
  }
}

/// Small rounded label, e.g. "-67%" in lime on forest.
class PillBadge extends StatelessWidget {
  const PillBadge(this.text, {super.key, required this.background, required this.foreground, this.icon});

  final String text;
  final Color background;
  final Color foreground;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(999)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 14, color: foreground), const SizedBox(width: 4)],
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: foreground, fontWeight: FontWeight.w700, fontSize: 12.5, letterSpacing: 0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A numbered step heading: an orange numeral and a title.
class StepHeading extends StatelessWidget {
  const StepHeading({super.key, required this.number, required this.title, this.subtitle});

  final int number;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(number.toString().padLeft(2, '0'), style: displayStyle(28, color: RefreshiColors.orangeInk)),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: displayStyle(24, color: scheme.onSurface)),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 14)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Horizontal dashed rule, as on a till receipt.
class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key, this.color, this.height = 24});

  final Color? color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _DashPainter(color ?? Theme.of(context).colorScheme.outlineVariant)),
    );
  }
}

class _DashPainter extends CustomPainter {
  const _DashPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    final y = size.height / 2;
    for (double x = 0; x < size.width; x += 9) {
      canvas.drawLine(Offset(x, y), Offset(math.min(x + 4, size.width), y), paint);
    }
  }

  @override
  bool shouldRepaint(_DashPainter oldDelegate) => oldDelegate.color != color;
}

/// Clips a receipt's bottom edge into a zig-zag tear.
class ReceiptClipper extends CustomClipper<Path> {
  const ReceiptClipper({this.tooth = 10, this.radius = 24});

  final double tooth;
  final double radius;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, radius)
      ..quadraticBezierTo(0, 0, radius, 0)
      ..lineTo(size.width - radius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, radius)
      ..lineTo(size.width, size.height - tooth);
    final teeth = (size.width / (tooth * 2)).floor();
    final step = size.width / teeth;
    for (var i = teeth; i > 0; i--) {
      final x = i * step;
      path
        ..lineTo(x - step / 2, size.height)
        ..lineTo(x - step, size.height - tooth);
    }
    return path..close();
  }

  @override
  bool shouldReclip(ReceiptClipper oldClipper) => oldClipper.tooth != tooth || oldClipper.radius != radius;
}

/// Decorative half-discs, echoing the brand's "C" mark, for forest panels.
class BrandShapes extends StatelessWidget {
  const BrandShapes({super.key});

  @override
  Widget build(BuildContext context) => const IgnorePointer(child: CustomPaint(painter: _ShapesPainter()));
}

class _ShapesPainter extends CustomPainter {
  const _ShapesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.height * 0.62;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width + r * 0.15, size.height * 0.15), radius: r),
      math.pi / 2,
      math.pi,
      true,
      Paint()..color = RefreshiColors.lime.withValues(alpha: 0.10),
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width - r * 0.35, size.height * 1.05), radius: r * 0.55),
      math.pi,
      math.pi,
      true,
      Paint()..color = RefreshiColors.orange.withValues(alpha: 0.16),
    );
  }

  @override
  bool shouldRepaint(_ShapesPainter oldDelegate) => false;
}

/// A rounded forest panel with the brand shapes behind its content.
class ForestPanel extends StatelessWidget {
  const ForestPanel({super.key, required this.child, this.padding = const EdgeInsets.all(28)});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: ColoredBox(
        color: RefreshiColors.forest,
        child: Stack(
          children: [
            const Positioned.fill(child: BrandShapes()),
            Padding(padding: padding, child: child),
          ],
        ),
      ),
    );
  }
}

/// Fades and lifts a child into place, staggered by [index], once on build.
/// Skipped entirely when the platform asks for reduced motion.
class EntranceTransition extends StatelessWidget {
  const EntranceTransition({super.key, required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 260 + 50 * math.min(index, 6)),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(offset: Offset(0, 14 * (1 - t)), child: child),
      ),
      child: child,
    );
  }
}

/// Icon for a store category.
IconData categoryIcon(String category) => switch (category) {
  'BAKERY' => Icons.bakery_dining_outlined,
  'GROCERY' => Icons.eco_outlined,
  'CAFE' => Icons.local_cafe_outlined,
  'MEALS' => Icons.ramen_dining_outlined,
  _ => Icons.shopping_bag_outlined,
};

/// A quiet "back" link for flows that have no app-bar back button.
class BackLink extends StatelessWidget {
  const BackLink({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back_rounded, size: 18),
        label: Text(label),
      ),
    );
  }
}
