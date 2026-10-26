import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exception_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/checkout_catalog.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../datasources/catalog_remote_data_source.dart';
import '../models/catalog_mappers.dart';

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
