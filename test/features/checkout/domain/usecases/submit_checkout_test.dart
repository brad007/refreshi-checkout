import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/features/checkout/domain/usecases/submit_checkout.dart';
import 'package:refreshi_checkout/features/orders/domain/usecases/create_order.dart';

import '../../../../helpers/dummies.dart';
import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockCheckoutRepository repository;
  late MockCreateOrder createOrder;
  late SubmitCheckout submit;

  setUpAll(registerDummies);

  setUp(() {
    repository = MockCheckoutRepository();
    createOrder = MockCreateOrder();
    submit = SubmitCheckout(repository, createOrder);
    when(repository.saveDraft(any)).thenAnswer((_) async => right(unit));
    when(repository.startNewDraft()).thenAnswer((_) async => right(Fixtures.emptyDraft));
  });

  final draft = Fixtures.completeDraft;
  final params = CreateOrderParams(
    idempotencyKey: draft.idempotencyKey,
    serviceIds: draft.serviceIds,
    slotId: draft.slotId!,
    paymentMethodId: draft.paymentMethodId!,
  );

  test('marks the draft in flight, places the order with the draft key, then rotates the draft', () async {
    when(createOrder(any)).thenAnswer((_) async => right(Fixtures.placement()));

    final result = await submit(draft);

    expect(result, right(Fixtures.placement()));
    verifyInOrder([
      repository.saveDraft(draft.copyWith(submissionInFlight: true)),
      createOrder(params),
      repository.startNewDraft(),
    ]);
  });

  test('clears the in-flight flag on failure and keeps the same key for a retry', () async {
    when(createOrder(any)).thenAnswer((_) async => left(const Failure.network()));

    final result = await submit(draft);

    expect(result, left(const Failure.network()));
    verify(repository.saveDraft(draft.copyWith(submissionInFlight: false)));
    verifyNever(repository.startNewDraft());
  });

  test('does not place the order if the in-flight marker cannot be saved', () async {
    when(repository.saveDraft(any)).thenAnswer((_) async => left(const Failure.cache()));

    expect(await submit(draft), left(const Failure.cache()));
    verifyNever(createOrder(any));
  });

  for (final (description, incomplete) in [
    ('services', draft.copyWith(serviceIds: [])),
    ('a slot', draft.copyWith(slotId: null)),
    ('a payment method', draft.copyWith(paymentMethodId: null)),
  ]) {
    test('rejects a draft without $description', () async {
      final result = await submit(incomplete);
      expect(result.getLeft().toNullable(), isA<InvalidInputFailure>());
      verifyZeroInteractions(createOrder);
      verifyZeroInteractions(repository);
    });
  }
}
