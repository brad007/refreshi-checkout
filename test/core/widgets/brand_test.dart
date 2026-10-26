import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/core/widgets/app_shell.dart';
import 'package:refreshi_checkout/core/widgets/brand.dart';

void main() {
  test('maps each store category to an icon, with a fallback', () {
    expect(categoryIcon('BAKERY'), Icons.bakery_dining_outlined);
    expect(categoryIcon('GROCERY'), Icons.eco_outlined);
    expect(categoryIcon('CAFE'), Icons.local_cafe_outlined);
    expect(categoryIcon('MEALS'), Icons.ramen_dining_outlined);
    expect(categoryIcon('SOMETHING_NEW'), Icons.shopping_bag_outlined);
  });

  test('the receipt clipper re-clips only when its shape changes', () {
    const clipper = ReceiptClipper();
    expect(clipper.shouldReclip(const ReceiptClipper()), isFalse);
    expect(clipper.shouldReclip(const ReceiptClipper(tooth: 12)), isTrue);
    final path = clipper.getClip(const Size(200, 100));
    expect(path.getBounds().width, closeTo(200, 0.01));
  });

  testWidgets('brand pieces render', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              RefreshiLogo(),
              DashedDivider(),
              StepHeading(number: 3, title: 'Title'),
              PillBadge('Plain', background: Colors.black, foreground: Colors.white),
              SizedBox(height: 120, child: ForestPanel(child: Text('Panel'))),
            ],
          ),
        ),
      ),
    );
    expect(find.text('refreshi'), findsOneWidget);
    expect(find.text('03'), findsOneWidget);
    expect(find.text('Panel'), findsOneWidget);

    // Repainting with the same inputs is a no-op; a new colour repaints.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: DashedDivider(color: Colors.red)),
      ),
    );
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: DashedDivider(color: Colors.blue)),
      ),
    );
    expect(find.byType(DashedDivider), findsOneWidget);
  });

  testWidgets('entrance animation is skipped when reduced motion is requested', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: EntranceTransition(index: 2, child: Text('Shown')),
        ),
      ),
    );
    expect(find.byType(TweenAnimationBuilder<double>), findsNothing);
    expect(find.text('Shown'), findsOneWidget);
  });
}
