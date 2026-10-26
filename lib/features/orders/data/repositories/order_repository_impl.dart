import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exception_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/graphql/__generated/schema.graphql.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_placement.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_data_source.dart';
import '../models/order_mappers.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl(this._remote);

  final OrderRemoteDataSource _remote;

  @override
  Future<Either<Failure, OrderPlacement>> createOrder({
    required String idempotencyKey,
    required List<String> serviceIds,
    required String slotId,
    required String paymentMethodId,
  }) async {
    try {
      final payload = await _remote.createOrder(
        Input$CreateOrderInput(
          idempotencyKey: idempotencyKey,
          serviceIds: serviceIds,
          slotId: slotId,
          paymentMethodId: paymentMethodId,
        ),
      );
      return right(payload.toEntity());
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, CustomerOrder>> getOrder(String id) async {
    try {
      return right((await _remote.getOrder(id)).toEntity());
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Stream<Either<Failure, CustomerOrder>> watchOrder(String id) => _remote
      .watchOrder(id)
      .map<Either<Failure, CustomerOrder>>((order) => right(order.toEntity()))
      .transform(_exceptionsToFailures());

  StreamTransformer<Either<Failure, CustomerOrder>, Either<Failure, CustomerOrder>> _exceptionsToFailures() =>
      StreamTransformer.fromHandlers(
        handleError: (error, stackTrace, sink) {
          if (error is Exception) {
            sink.add(left(mapExceptionToFailure(error)));
          } else {
            sink.addError(error, stackTrace);
          }
        },
      );
}
