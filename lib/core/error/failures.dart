import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Domain-level errors. Repositories translate data-layer exceptions into
/// these so the presentation layer never sees transport details.
@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.server({String? message}) = ServerFailure;
  const factory Failure.network() = NetworkFailure;
  const factory Failure.cache() = CacheFailure;
  const factory Failure.notFound() = NotFoundFailure;
  const factory Failure.invalidInput({required String message}) = InvalidInputFailure;

  /// The idempotency key was already used for a *different* request. The
  /// order created by the original request is returned so the UI can link to it.
  const factory Failure.idempotencyConflict({String? existingOrderId}) = IdempotencyConflictFailure;

  String get userMessage => switch (this) {
    ServerFailure(:final message) => message ?? 'Something went wrong. Please try again.',
    NetworkFailure() => 'We couldn\'t reach the server. Check your connection and try again.',
    CacheFailure() => 'We couldn\'t read saved data on this device.',
    NotFoundFailure() => 'We can\'t find that. Check the link, or start a new rescue.',
    InvalidInputFailure(:final message) => message,
    IdempotencyConflictFailure() =>
      'You\'ve already placed an order from this checkout. View it, or start a new checkout to order again.',
  };
}
