import 'package:flutter_test/flutter_test.dart';
import 'package:gql/language.dart';
import 'package:graphql/client.dart' as gql;
import 'package:refreshi_checkout/core/error/exceptions.dart';
import 'package:refreshi_checkout/core/graphql/graphql_result_x.dart';

gql.QueryResult<String> _result({Object? data, gql.OperationException? exception}) => gql.QueryResult<String>(
  options: gql.QueryOptions<String>(document: parseString('{ a }'), parserFn: (json) => json['a'] as String),
  source: gql.QueryResultSource.network,
  data: data as Map<String, dynamic>?,
  exception: exception,
);

void main() {
  test('returns parsed data', () {
    expect(_result(data: {'a': 'value'}).requireData(), 'value');
  });

  test('throws ServerException carrying the GraphQL error code and extensions', () {
    final result = _result(
      exception: gql.OperationException(
        graphqlErrors: const [
          gql.GraphQLError(message: 'Reused', extensions: {'code': 'IDEMPOTENCY_KEY_REUSED', 'orderId': 'o1'}),
        ],
      ),
    );
    expect(
      result.requireData,
      throwsA(
        isA<ServerException>()
            .having((e) => e.code, 'code', ErrorCodes.idempotencyKeyReused)
            .having((e) => e.message, 'message', 'Reused')
            .having((e) => e.extensions['orderId'], 'orderId', 'o1'),
      ),
    );
  });

  test('defaults the code when the server sends none', () {
    final result = _result(
      exception: gql.OperationException(graphqlErrors: const [gql.GraphQLError(message: 'x')]),
    );
    expect(result.requireData, throwsA(isA<ServerException>().having((e) => e.code, 'code', ErrorCodes.internal)));
  });

  test('throws NetworkException for link failures', () {
    final result = _result(
      exception: gql.OperationException(linkException: gql.UnknownException(Exception('down'), StackTrace.empty)),
    );
    expect(result.requireData, throwsA(isA<NetworkException>()));
  });

  test('throws when there is neither data nor an error', () {
    expect(_result().requireData, throwsA(isA<ServerException>()));
  });
}
