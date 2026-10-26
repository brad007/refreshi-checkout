import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/core/error/exceptions.dart';
import 'package:refreshi_checkout/core/graphql/__generated/schema.graphql.dart';
import 'package:refreshi_checkout/features/orders/data/datasources/order_remote_data_source.dart';

import '../../../../helpers/local_api.dart';

void main() {
  late LocalApi api;
  late OrderRemoteDataSourceImpl dataSource;

  setUp(() async {
    api = await LocalApi.create();
    dataSource = OrderRemoteDataSourceImpl(api.client);
  });

  tearDown(() => api.dispose());

  Input$CreateOrderInput input({String key = 'key-1', List<String> serviceIds = const ['bag_grocer']}) =>
      Input$CreateOrderInput(
        idempotencyKey: key,
        serviceIds: serviceIds,
        slotId: api.tomorrowSlotId,
        paymentMethodId: '8ac7a4a28a5f1e3c018a6b2e0d7f4a01',
      );

  group('createOrder', () {
    test('creates an order with a pending hold', () async {
      final payload = await dataSource.createOrder(input());
      expect(payload.replayed, isFalse);
      expect(payload.order.status, Enum$OrderStatus.AWAITING_HOLD);
      expect(payload.order.hold.status, Enum$HoldStatus.PENDING);
      expect(payload.order.items.single.serviceId, 'bag_grocer');
      expect(payload.order.slot.id, api.tomorrowSlotId);
    });

    test('concurrent submissions with one key yield one order', () async {
      final results = await Future.wait([dataSource.createOrder(input()), dataSource.createOrder(input())]);
      expect(results[0].order.id, results[1].order.id);
      expect(results.where((r) => r.replayed), hasLength(1));
    });

    test('a reused key with a different order is rejected with the original id', () async {
      final original = await dataSource.createOrder(input());
      expect(
        () => dataSource.createOrder(input(serviceIds: ['bag_cafe'])),
        throwsA(
          isA<ServerException>()
              .having((e) => e.code, 'code', ErrorCodes.idempotencyKeyReused)
              .having((e) => e.extensions['orderId'], 'orderId', original.order.id),
        ),
      );
    });
  });

  group('getOrder', () {
    test('fetches an existing order', () async {
      final created = await dataSource.createOrder(input());
      final fetched = await dataSource.getOrder(created.order.id);
      expect(fetched, created.order);
    });

    test('throws NOT_FOUND for an unknown id', () {
      expect(
        () => dataSource.getOrder('ord_missing'),
        throwsA(isA<ServerException>().having((e) => e.code, 'code', ErrorCodes.notFound)),
      );
    });
  });

  group('watchOrder', () {
    test('streams the pending order, then the placed hold, then completes', () async {
      final created = await dataSource.createOrder(input());
      final statuses = await dataSource.watchOrder(created.order.id).map((o) => o.hold.status).toList();
      expect(statuses, [Enum$HoldStatus.PENDING, Enum$HoldStatus.PLACED]);
    });

    test('errors with NOT_FOUND for an unknown id', () {
      expect(
        dataSource.watchOrder('ord_missing'),
        emitsError(isA<ServerException>().having((e) => e.code, 'code', ErrorCodes.notFound)),
      );
    });
  });
}
