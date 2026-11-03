import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../core/usecase.dart';
import '../../domain/orders/order.dart';
import '../../domain/orders/order_repository.dart';

@lazySingleton
class GetOrder implements UseCase<CustomerOrder, String> {
  const GetOrder(this._repository);

  final OrderRepository _repository;

  @override
  Future<Either<Failure, CustomerOrder>> call(String orderId) => _repository.getOrder(orderId);
}
