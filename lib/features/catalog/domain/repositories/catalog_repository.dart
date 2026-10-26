import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/checkout_catalog.dart';

abstract interface class CatalogRepository {
  Future<Either<Failure, CheckoutCatalog>> getCheckoutCatalog({required int days});
}
