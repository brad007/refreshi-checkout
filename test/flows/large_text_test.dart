import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/features/orders/domain/entities/order.dart';

import '../helpers/app_harness.dart';
import '../helpers/fixtures.dart';

/// Every screen must lay out without overflow for users with large text,
/// on a phone and on a desktop. Any RenderFlex overflow fails the test.
void main() {
  const sizes = {'phone': Size(375, 812), 'desktop': Size(1280, 800)};
  const scales = [1.5, 2.0];

  for (final MapEntry(key: device, value: size) in sizes.entries) {
    for (final scale in scales) {
      group('$device at ${scale}x text', () {
        late AppHarness app;

        setUp(() {
          app = AppHarness();
          app.draft(Fixtures.emptyDraft.copyWith(serviceIds: ['bag_bakery', 'bag_grocer']));
        });

        testWidgets('catalog', (tester) async {
          await app.pump(tester, size: size, textScale: scale);
          expect(tester.takeException(), isNull);
        });

        testWidgets('sign-in', (tester) async {
          app.signedIn(false);
          await app.pump(tester, path: '/sign-in', size: size, textScale: scale);
          expect(tester.takeException(), isNull);
        });

        testWidgets('checkout', (tester) async {
          app.draft(Fixtures.completeDraft);
          await app.pump(tester, path: '/checkout', size: size, textScale: scale);
          expect(tester.takeException(), isNull);
        });

        for (final hold in HoldStatus.values) {
          testWidgets('order ($hold)', (tester) async {
            when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order(hold: hold)));
            when(app.watchOrder(any)).thenAnswer((_) => const Stream.empty());
            await app.pump(tester, path: '/orders/ord_1', size: size, textScale: scale);
            expect(tester.takeException(), isNull);
          });
        }
      });
    }
  }
}
