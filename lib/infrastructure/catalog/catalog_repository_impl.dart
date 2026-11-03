import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../core/exception_mapper.dart';
import '../../domain/core/failures.dart';
import '../../domain/catalog/checkout_catalog.dart';
import '../../domain/catalog/catalog_repository.dart';
import 'catalog_remote_data_source.dart';
import 'catalog_mappers.dart';

@LazySingleton(as: CatalogRepository)
class CatalogRepositoryImpl implements CatalogRepository {
  const CatalogRepositoryImpl(this._remote);

  final CatalogRemoteDataSource _remote;

  @override
  Future<Either<Failure, CheckoutCatalog>> getCheckoutCatalog({required int days}) async {
    try {
      final data = await _remote.getCheckoutCatalog(days: days);
      return right(data.toEntity());
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
