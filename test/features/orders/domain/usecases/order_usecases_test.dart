import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/features/orders/domain/usecases/create_order.dart';
import 'package:refreshi_checkout/features/orders/domain/usecases/get_order.dart';
import 'package:refreshi_checkout/features/orders/domain/usecases/watch_order.dart';

import '../../../../helpers/dummies.dart';
import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockOrderRepository repository;

  setUpAll(registerDummies);
  setUp(() => repository = MockOrderRepository());

  const params = CreateOrderParams(
    idempotencyKey: 'k',
    serviceIds: ['bag_grocer'],
    slotId: 'slot_1',
    paymentMethodId: '8ac7a4a28a5f1e3c018a6b2e0d7f4a01',
  );

  group('CreateOrder', () {
    test('passes every field through, including the idempotency key', () async {
      when(
        repository.createOrder(
          idempotencyKey: anyNamed('idempotencyKey'),
          serviceIds: anyNamed('serviceIds'),
          slotId: anyNamed('slotId'),
          paymentMethodId: anyNamed('paymentMethodId'),
        ),
      ).thenAnswer((_) async => right(Fixtures.placement()));

      expect(await CreateOrder(repository)(params), right(Fixtures.placement()));
      verify(
        repository.createOrder(
          idempotencyKey: 'k',
          serviceIds: ['bag_grocer'],
          slotId: 'slot_1',
          paymentMethodId: '8ac7a4a28a5f1e3c018a6b2e0d7f4a01',
        ),
      );
    });

    test('rejects an empty order', () async {
      const empty = CreateOrderParams(idempotencyKey: 'k', serviceIds: [], slotId: 's', paymentMethodId: 'p');
      final result = await CreateOrder(repository)(empty);
      expect(result.getLeft().toNullable(), isA<InvalidInputFailure>());
      verifyZeroInteractions(repository);
    });

    test('params have value equality', () {
      expect(
        params,
        const CreateOrderParams(
          idempotencyKey: 'k',
          serviceIds: ['bag_grocer'],
          slotId: 'slot_1',
          paymentMethodId: '8ac7a4a28a5f1e3c018a6b2e0d7f4a01',
        ),
      );
    });
  });

  test('GetOrder delegates', () async {
    when(repository.getOrder(any)).thenAnswer((_) async => right(Fixtures.order()));
    expect(await GetOrder(repository)('ord_1'), right(Fixtures.order()));
  });

  test('WatchOrder delegates', () {
    when(repository.watchOrder(any)).thenAnswer((_) => Stream.value(right(Fixtures.order())));
    expect(WatchOrder(repository)('ord_1'), emits(right<Failure, dynamic>(Fixtures.order())));
  });
}
