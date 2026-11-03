import 'package:fpdart/fpdart.dart';

import '../core/failures.dart';
import 'checkout_catalog.dart';

abstract interface class CatalogRepository {
  Future<Either<Failure, CheckoutCatalog>> getCheckoutCatalog({required int days});
}
