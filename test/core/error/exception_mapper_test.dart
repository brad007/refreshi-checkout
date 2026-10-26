import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/core/error/exception_mapper.dart';
import 'package:refreshi_checkout/core/error/exceptions.dart';
import 'package:refreshi_checkout/core/error/failures.dart';

void main() {
  test('maps every exception to the matching failure', () {
    expect(mapExceptionToFailure(const ServerException(code: ErrorCodes.notFound)), const Failure.notFound());
    expect(
      mapExceptionToFailure(const ServerException(code: ErrorCodes.badUserInput, message: 'Bad slot')),
      const Failure.invalidInput(message: 'Bad slot'),
    );
    expect(mapExceptionToFailure(const ServerException(code: ErrorCodes.badUserInput)), isA<InvalidInputFailure>());
    expect(
      mapExceptionToFailure(
        const ServerException(code: ErrorCodes.idempotencyKeyReused, extensions: {'orderId': 'ord_1'}),
      ),
      const Failure.idempotencyConflict(existingOrderId: 'ord_1'),
    );
    expect(
      mapExceptionToFailure(const ServerException(code: ErrorCodes.internal, message: 'Oops')),
      const Failure.server(message: 'Oops'),
    );
    expect(mapExceptionToFailure(const NetworkException()), const Failure.network());
    expect(mapExceptionToFailure(const CacheException()), const Failure.cache());
    expect(mapExceptionToFailure(Exception('?')), const Failure.server());
  });

  test('every failure has a user-facing message', () {
    const failures = [
      Failure.server(),
      Failure.server(message: 'Custom'),
      Failure.network(),
      Failure.cache(),
      Failure.notFound(),
      Failure.invalidInput(message: 'Fix it'),
      Failure.idempotencyConflict(),
    ];
    for (final failure in failures) {
      expect(failure.userMessage, isNotEmpty);
    }
    expect(const Failure.server(message: 'Custom').userMessage, 'Custom');
    expect(const Failure.invalidInput(message: 'Fix it').userMessage, 'Fix it');
  });

  test('exceptions describe themselves', () {
    expect(const ServerException(code: 'X', message: 'm').toString(), contains('X'));
    expect(const NetworkException('n').toString(), contains('n'));
    expect(const CacheException('c').toString(), contains('c'));
  });
}
