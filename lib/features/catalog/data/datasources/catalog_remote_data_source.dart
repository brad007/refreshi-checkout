import 'package:graphql/client.dart' hide NetworkException, ServerException;
import 'package:injectable/injectable.dart';

import '../../../../core/graphql/graphql_result_x.dart';
import '../graphql/__generated/catalog.graphql.dart';

abstract interface class CatalogRemoteDataSource {
  /// Throws ServerException / NetworkException on failure.
  Future<Query$CheckoutCatalog> getCheckoutCatalog({required int days});
}

@LazySingleton(as: CatalogRemoteDataSource)
class CatalogRemoteDataSourceImpl implements CatalogRemoteDataSource {
  const CatalogRemoteDataSourceImpl(this._client);

  final GraphQLClient _client;

  @override
  Future<Query$CheckoutCatalog> getCheckoutCatalog({required int days}) async {
    final result = await _client.query$CheckoutCatalog(
      Options$Query$CheckoutCatalog(variables: Variables$Query$CheckoutCatalog(days: days)),
    );
    return result.requireData();
  }
}
