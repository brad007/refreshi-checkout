/// Thrown by data sources when the GraphQL API returns an error.
class ServerException implements Exception {
  const ServerException({required this.code, this.message, this.extensions = const {}});

  final String code;
  final String? message;
  final Map<String, dynamic> extensions;

  @override
  String toString() => 'ServerException($code: $message)';
}

/// Thrown by data sources when the transport fails (no response at all).
class NetworkException implements Exception {
  const NetworkException([this.message]);

  final String? message;

  @override
  String toString() => 'NetworkException($message)';
}

/// Thrown by local data sources when persisted data can't be read or written.
class CacheException implements Exception {
  const CacheException([this.message]);

  final String? message;

  @override
  String toString() => 'CacheException($message)';
}

/// Error codes shared by the local backend and the client data sources.
abstract final class ErrorCodes {
  static const notFound = 'NOT_FOUND';
  static const badUserInput = 'BAD_USER_INPUT';
  static const idempotencyKeyReused = 'IDEMPOTENCY_KEY_REUSED';
  static const internal = 'INTERNAL';
}
