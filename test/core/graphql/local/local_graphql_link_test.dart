import 'package:flutter_test/flutter_test.dart';
import 'package:gql/language.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:refreshi_checkout/core/graphql/local/local_graphql_executor.dart';
import 'package:refreshi_checkout/core/graphql/local/local_graphql_link.dart';

void main() {
  test('executes requests in-process', () async {
    final link = LocalGraphQLLink(LocalGraphQLExecutor(query: {'hello': (_) => 'world'}));
    final response = await link
        .request(
          Request(
            operation: Operation(document: parseString('{ hello }')),
            variables: const {},
          ),
        )
        .first;
    expect(response.data, {'hello': 'world'});
  });
}
