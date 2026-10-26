import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

@lazySingleton
class WatchOrder implements StreamUseCase<CustomerOrder, String> {
  const WatchOrder(this._repository);

  final OrderRepository _repository;

  @override
  Stream<Either<Failure, CustomerOrder>> call(String orderId) => _repository.watchOrder(orderId);
}
