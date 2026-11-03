import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../core/usecase.dart';
import '../../domain/catalog/checkout_catalog.dart';
import '../../domain/catalog/catalog_repository.dart';

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
