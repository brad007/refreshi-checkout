import 'package:fpdart/fpdart.dart';

import '../core/failures.dart';
import 'order.dart';
import 'order_placement.dart';

abstract interface class OrderRepository {
  Future<Either<Failure, OrderPlacement>> createOrder({
    required String idempotencyKey,
    required List<String> serviceIds,
    required String slotId,
    required String paymentMethodId,
  });

  Future<Either<Failure, CustomerOrder>> getOrder(String id);

  /// Emits the current order, then every update until the order is final.
  Stream<Either<Failure, CustomerOrder>> watchOrder(String id);
}
