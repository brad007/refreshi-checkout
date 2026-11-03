import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../core/usecase.dart';
import '../../domain/orders/order.dart';
import '../../domain/orders/order_repository.dart';

@lazySingleton
class WatchOrder implements StreamUseCase<CustomerOrder, String> {
  const WatchOrder(this._repository);

  final OrderRepository _repository;

  @override
  Stream<Either<Failure, CustomerOrder>> call(String orderId) => _repository.watchOrder(orderId);
}
