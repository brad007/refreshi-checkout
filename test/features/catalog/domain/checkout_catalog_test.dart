import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/features/catalog/domain/entities/payment_method.dart';

import '../../../helpers/fixtures.dart';

void main() {
  test('looks entries up by id', () {
    final catalog = Fixtures.catalog;
    expect(catalog.serviceById('bag_cafe'), Fixtures.cafe);
    expect(catalog.serviceById('nope'), isNull);
    expect(catalog.slotById('slot_2'), Fixtures.slotNextDay);
    expect(catalog.slotById(null), isNull);
    expect(catalog.paymentMethodById(Fixtures.mastercard.id), Fixtures.mastercard);
    expect(catalog.paymentMethodById(null), isNull);
  });

  test('bags know their saving', () {
    expect(Fixtures.bakery.savingsCents, 13000);
    expect(Fixtures.bakery.savingsPercent, 67);
    expect(Fixtures.bakery.copyWith(originalPriceCents: 0).savingsPercent, 0);
  });

  test('derived values', () {
    expect(const PaymentMethod(id: 'p', brand: 'Visa', last4: '1234').label, 'Visa •••• 1234');
    expect(Fixtures.slot.day, DateTime(2030, 1, 2));
  });
}
