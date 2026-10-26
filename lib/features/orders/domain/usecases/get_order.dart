import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

@lazySingleton
class GetOrder implements UseCase<CustomerOrder, String> {
  const GetOrder(this._repository);

  final OrderRepository _repository;

  @override
  Future<Either<Failure, CustomerOrder>> call(String orderId) => _repository.getOrder(orderId);
}
