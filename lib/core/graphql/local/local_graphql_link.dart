import 'package:gql_exec/gql_exec.dart';
import 'package:gql_link/gql_link.dart';

import 'local_graphql_executor.dart';

/// Terminating link that executes operations in-process instead of over HTTP.
///
/// It is the only thing that differs from a production setup: swapping it for
/// an `HttpLink` would point the same typed client at a real server.
class LocalGraphQLLink extends Link {
  LocalGraphQLLink(this._executor);

  final LocalGraphQLExecutor _executor;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) => _executor.execute(request);
}
