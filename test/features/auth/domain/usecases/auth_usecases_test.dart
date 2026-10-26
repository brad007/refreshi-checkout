import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/core/usecase/usecase.dart';
import 'package:refreshi_checkout/features/auth/domain/usecases/get_current_session.dart';
import 'package:refreshi_checkout/features/auth/domain/usecases/sign_in.dart';
import 'package:refreshi_checkout/features/auth/domain/usecases/sign_out.dart';

import '../../../../helpers/dummies.dart';
import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockAuthRepository repository;

  setUpAll(registerDummies);
  setUp(() => repository = MockAuthRepository());

  test('GetCurrentSession delegates to the repository', () async {
    when(repository.currentSession()).thenAnswer((_) async => right(some(Fixtures.session)));
    expect(await GetCurrentSession(repository)(const NoParams()), right(some(Fixtures.session)));
  });

  group('SignIn', () {
    test('trims and lower-cases the email', () async {
      when(repository.signIn(email: anyNamed('email'))).thenAnswer((_) async => right(Fixtures.session));
      final result = await SignIn(repository)('  Test@Example.com ');
      expect(result, right(Fixtures.session));
      verify(repository.signIn(email: 'test@example.com'));
    });

    for (final invalid in ['', 'nope', 'a@b', 'a b@c.d']) {
      test('rejects "$invalid" without touching the repository', () async {
        final result = await SignIn(repository)(invalid);
        expect(result.getLeft().toNullable(), isA<InvalidInputFailure>());
        verifyNever(repository.signIn(email: anyNamed('email')));
      });
    }
  });

  test('SignOut delegates to the repository', () async {
    when(repository.signOut()).thenAnswer((_) async => right(unit));
    expect(await SignOut(repository)(const NoParams()), right(unit));
  });

  test('failures pass through unchanged', () async {
    when(repository.signOut()).thenAnswer((_) async => left(const Failure.cache()));
    expect(await SignOut(repository)(const NoParams()), left(const Failure.cache()));
  });
}
