import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/features/checkout/domain/entities/checkout_draft.dart';

void main() {
  const draft = CheckoutDraft(idempotencyKey: 'k');

  test('toggles services on and off', () {
    final one = draft.toggleService('a');
    expect(one.serviceIds, ['a']);
    expect(one.toggleService('a').serviceIds, isEmpty);
  });

  test('caps the number of services', () {
    final full = draft.toggleService('a').toggleService('b');
    expect(full.canAddMoreServices, isFalse);
    expect(full.toggleService('c'), full);
    expect(full.toggleService('a').serviceIds, ['b'], reason: 'removing still works when full');
  });

  test('is complete only with services, a slot and a payment method', () {
    expect(draft.isEmpty, isTrue);
    expect(draft.isComplete, isFalse);
    final withService = draft.toggleService('a');
    expect(withService.isComplete, isFalse);
    expect(withService.copyWith(slotId: 's').isComplete, isFalse);
    expect(withService.copyWith(slotId: 's', paymentMethodId: 'p').isComplete, isTrue);
  });
}
