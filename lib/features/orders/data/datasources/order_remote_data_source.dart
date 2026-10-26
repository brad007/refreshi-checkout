import 'package:graphql/client.dart' hide NetworkException, ServerException;
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/graphql/__generated/schema.graphql.dart';
import '../../../../core/graphql/graphql_result_x.dart';
import '../graphql/__generated/orders.graphql.dart';

abstract interface class OrderRemoteDataSource {
  Future<Mutation$CreateOrder$createOrder> createOrder(Input$CreateOrderInput input);

  /// Throws ServerException with [ErrorCodes.notFound] when there is no order.
  Future<Fragment$OrderFields> getOrder(String id);

  Stream<Fragment$OrderFields> watchOrder(String id);
}

@LazySingleton(as: OrderRemoteDataSource)
class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  const OrderRemoteDataSourceImpl(this._client);

  final GraphQLClient _client;

  @override
  Future<Mutation$CreateOrder$createOrder> createOrder(Input$CreateOrderInput input) async {
    final result = await _client.mutate$CreateOrder(
      Options$Mutation$CreateOrder(variables: Variables$Mutation$CreateOrder(input: input)),
    );
    return result.requireData().createOrder;
  }

  @override
  Future<Fragment$OrderFields> getOrder(String id) async {
    final result = await _client.query$OrderDetails(
      Options$Query$OrderDetails(variables: Variables$Query$OrderDetails(id: id)),
    );
    final order = result.requireData().order;
    if (order == null) throw const ServerException(code: ErrorCodes.notFound, message: 'Order not found');
    return order;
  }

  @override
  Stream<Fragment$OrderFields> watchOrder(String id) => _client
      .subscribe$OrderUpdated(Options$Subscription$OrderUpdated(variables: Variables$Subscription$OrderUpdated(id: id)))
      // The client emits a loading placeholder before the first event.
      .where((result) => !result.isLoading)
      .map((result) => result.requireData().orderUpdated);
}
