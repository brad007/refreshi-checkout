import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/order_placement.dart';
import '../repositories/order_repository.dart';

@lazySingleton
class CreateOrder implements UseCase<OrderPlacement, CreateOrderParams> {
  const CreateOrder(this._repository);

  final OrderRepository _repository;

  @override
  Future<Either<Failure, OrderPlacement>> call(CreateOrderParams params) async {
    if (params.serviceIds.isEmpty) {
      return left(const Failure.invalidInput(message: 'Select at least one service.'));
    }
    return _repository.createOrder(
      idempotencyKey: params.idempotencyKey,
      serviceIds: params.serviceIds,
      slotId: params.slotId,
      paymentMethodId: params.paymentMethodId,
    );
  }
}

class CreateOrderParams extends Equatable {
  const CreateOrderParams({
    required this.idempotencyKey,
    required this.serviceIds,
    required this.slotId,
    required this.paymentMethodId,
  });

  final String idempotencyKey;
  final List<String> serviceIds;
  final String slotId;
  final String paymentMethodId;

  @override
  List<Object> get props => [idempotencyKey, serviceIds, slotId, paymentMethodId];
}
