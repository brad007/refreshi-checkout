import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/exceptions.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/core/graphql/__generated/schema.graphql.dart';
import 'package:refreshi_checkout/features/catalog/data/graphql/__generated/catalog.graphql.dart';
import 'package:refreshi_checkout/features/orders/data/graphql/__generated/orders.graphql.dart';
import 'package:refreshi_checkout/features/orders/data/repositories/order_repository_impl.dart';

import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockOrderRemoteDataSource remote;
  late OrderRepositoryImpl repository;

  final at = DateTime.utc(2030);
  Fragment$OrderFields fields(Enum$HoldStatus hold) => Fragment$OrderFields(
    id: 'ord_1',
    status: Enum$OrderStatus.AWAITING_HOLD,
    items: const [],
    slot: Fragment$TimeSlotFields(id: 't', startsAt: at, endsAt: at),
    paymentMethod: Fragment$PaymentMethodFields(id: 'p', brand: 'Visa', last4: '4242'),
    totalCents: 0,
    currency: 'ZAR',
    hold: Fragment$OrderFields$hold(
      id: 'h',
      status: hold,
      amountCents: 0,
      provider: 'PEACH_PAYMENTS',
      paymentType: 'PA',
      reference: 'ref',
      resultCode: '000.100.110',
      resultDescription: 'ok',
    ),
    timeline: const [],
    createdAt: at,
  );

  setUp(() {
    remote = MockOrderRemoteDataSource();
    repository = OrderRepositoryImpl(remote);
  });

  group('createOrder', () {
    test('sends the typed input and maps the payload', () async {
      when(remote.createOrder(any)).thenAnswer(
        (_) async => Mutation$CreateOrder$createOrder(order: fields(Enum$HoldStatus.PENDING), replayed: false),
      );

      final result = await repository.createOrder(
        idempotencyKey: 'k',
        serviceIds: ['a'],
        slotId: 's',
        paymentMethodId: 'p',
      );

      expect(result.toNullable()!.order.id, 'ord_1');
      verify(
        remote.createOrder(
          Input$CreateOrderInput(idempotencyKey: 'k', serviceIds: ['a'], slotId: 's', paymentMethodId: 'p'),
        ),
      );
    });

    test('maps an idempotency conflict to its failure', () async {
      when(remote.createOrder(any))
          .thenThrow(const ServerException(code: ErrorCodes.idempotencyKeyReused, extensions: {'orderId': 'ord_0'}));
      final result = await repository.createOrder(
        idempotencyKey: 'k',
        serviceIds: ['a'],
        slotId: 's',
        paymentMethodId: 'p',
      );
      expect(result, left(const Failure.idempotencyConflict(existingOrderId: 'ord_0')));
    });
  });

  group('getOrder', () {
    test('maps the order', () async {
      when(remote.getOrder(any)).thenAnswer((_) async => fields(Enum$HoldStatus.PENDING));
      expect((await repository.getOrder('ord_1')).toNullable()!.isPending, isTrue);
    });

    test('maps NOT_FOUND', () async {
      when(remote.getOrder(any)).thenThrow(const ServerException(code: ErrorCodes.notFound));
      expect(await repository.getOrder('x'), left(const Failure.notFound()));
    });
  });

  group('watchOrder', () {
    test('maps each update', () async {
      when(remote.watchOrder(any))
          .thenAnswer((_) => Stream.fromIterable([fields(Enum$HoldStatus.PENDING), fields(Enum$HoldStatus.PLACED)]));
      final updates = await repository.watchOrder('ord_1').toList();
      expect(updates.map((u) => u.toNullable()!.isPending), [true, false]);
    });

    test('turns stream exceptions into failure values', () async {
      when(remote.watchOrder(any)).thenAnswer((_) => Stream.error(const NetworkException()));
      expect(await repository.watchOrder('ord_1').toList(), [left(const Failure.network())]);
    });

    test('lets programming errors through', () {
      when(remote.watchOrder(any)).thenAnswer((_) => Stream.error(StateError('bug')));
      expect(repository.watchOrder('ord_1'), emitsError(isA<StateError>()));
    });
  });
}
