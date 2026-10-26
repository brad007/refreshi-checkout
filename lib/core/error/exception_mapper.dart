import 'exceptions.dart';
import 'failures.dart';

/// The single place where data-layer exceptions become domain failures.
Failure mapExceptionToFailure(Object error) => switch (error) {
  ServerException(code: ErrorCodes.notFound) => const Failure.notFound(),
  ServerException(code: ErrorCodes.badUserInput, :final message) => Failure.invalidInput(
    message: message ?? 'Please check your details and try again.',
  ),
  ServerException(code: ErrorCodes.idempotencyKeyReused, :final extensions) => Failure.idempotencyConflict(
    existingOrderId: extensions['orderId'] as String?,
  ),
  ServerException(:final message) => Failure.server(message: message),
  NetworkException() => const Failure.network(),
  CacheException() => const Failure.cache(),
  _ => const Failure.server(),
};
