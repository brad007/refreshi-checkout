import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/checkout_catalog.dart';
import '../repositories/catalog_repository.dart';

@lazySingleton
class GetCheckoutCatalog implements UseCase<CheckoutCatalog, NoParams> {
  const GetCheckoutCatalog(this._repository);

  /// How far ahead customers can book.
  static const bookingWindowDays = 7;

  final CatalogRepository _repository;

  @override
  Future<Either<Failure, CheckoutCatalog>> call(NoParams params) =>
      _repository.getCheckoutCatalog(days: bookingWindowDays);
}
