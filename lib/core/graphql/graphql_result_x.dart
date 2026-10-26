import 'package:graphql/client.dart' hide NetworkException, ServerException;

import '../error/exceptions.dart';

extension GraphQLResultX<T> on QueryResult<T> {
  /// Returns the typed data or throws a data-layer exception, so data sources
  /// have one place that interprets transport and GraphQL errors.
  T requireData() {
    final exception = this.exception;
    if (exception != null) {
      final error = exception.graphqlErrors.firstOrNull;
      if (error != null) {
        final extensions = error.extensions ?? const <String, dynamic>{};
        throw ServerException(
          code: extensions['code'] as String? ?? ErrorCodes.internal,
          message: error.message,
          extensions: extensions,
        );
      }
      throw NetworkException(exception.linkException?.toString());
    }
    final data = parsedData;
    if (data == null) throw const ServerException(code: ErrorCodes.internal, message: 'Empty response');
    return data;
  }
}
