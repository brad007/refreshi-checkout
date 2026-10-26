import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/exceptions.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/features/auth/data/models/user_session_model.dart';
import 'package:refreshi_checkout/features/auth/data/repositories/auth_repository_impl.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockAuthLocalDataSource local;
  late AuthRepositoryImpl repository;

  setUp(() {
    local = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(local);
  });

  group('currentSession', () {
    test('returns some(session) when one is saved', () async {
      when(local.getSession()).thenReturn(const UserSessionModel(email: 'test@example.com'));
      expect(await repository.currentSession(), right(some(Fixtures.session)));
    });

    test('returns none when signed out', () async {
      when(local.getSession()).thenReturn(null);
      expect(await repository.currentSession(), right(none()));
    });

    test('returns CacheFailure when storage is unreadable', () async {
      when(local.getSession()).thenThrow(const CacheException());
      expect(await repository.currentSession(), left(const Failure.cache()));
    });
  });

  group('signIn', () {
    test('saves and returns the session', () async {
      expect(await repository.signIn(email: 'test@example.com'), right(Fixtures.session));
      verify(local.saveSession(const UserSessionModel(email: 'test@example.com')));
    });

    test('returns CacheFailure when the save fails', () async {
      when(local.saveSession(any)).thenThrow(const CacheException());
      expect(await repository.signIn(email: 'x@y.z'), left(const Failure.cache()));
    });
  });

  group('signOut', () {
    test('clears the session', () async {
      expect(await repository.signOut(), right(unit));
      verify(local.clearSession());
    });

    test('returns CacheFailure when clearing fails', () async {
      when(local.clearSession()).thenThrow(const CacheException());
      expect(await repository.signOut(), left(const Failure.cache()));
    });
  });
}
