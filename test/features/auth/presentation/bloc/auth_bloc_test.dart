import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../helpers/dummies.dart';
import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockGetCurrentSession getCurrentSession;
  late MockSignIn signIn;
  late MockSignOut signOut;

  setUpAll(registerDummies);

  setUp(() {
    getCurrentSession = MockGetCurrentSession();
    signIn = MockSignIn();
    signOut = MockSignOut();
  });

  AuthBloc build() => AuthBloc(getCurrentSession, signIn, signOut);

  test('starts unknown', () {
    expect(build().state, const AuthState());
    expect(build().state.isSignedIn, isFalse);
  });

  blocTest<AuthBloc, AuthState>(
    'started → signedIn when a session exists',
    setUp: () => when(getCurrentSession(any)).thenAnswer((_) async => right(some(Fixtures.session))),
    build: build,
    act: (bloc) => bloc.add(const AuthEvent.started()),
    expect: () => [const AuthState(status: AuthStatus.signedIn, session: Fixtures.session)],
  );

  blocTest<AuthBloc, AuthState>(
    'started → signedOut when there is no session',
    setUp: () => when(getCurrentSession(any)).thenAnswer((_) async => right(none())),
    build: build,
    act: (bloc) => bloc.add(const AuthEvent.started()),
    expect: () => [const AuthState(status: AuthStatus.signedOut)],
  );

  blocTest<AuthBloc, AuthState>(
    'started → signedOut when the session cannot be read',
    setUp: () => when(getCurrentSession(any)).thenAnswer((_) async => left(const Failure.cache())),
    build: build,
    act: (bloc) => bloc.add(const AuthEvent.started()),
    expect: () => [const AuthState(status: AuthStatus.signedOut)],
  );

  blocTest<AuthBloc, AuthState>(
    'signInRequested → submitting → signedIn',
    setUp: () => when(signIn(any)).thenAnswer((_) async => right(Fixtures.session)),
    build: build,
    seed: () => const AuthState(status: AuthStatus.signedOut),
    act: (bloc) => bloc.add(const AuthEvent.signInRequested('test@example.com')),
    expect: () => [
      const AuthState(status: AuthStatus.signedOut, isSubmitting: true),
      const AuthState(status: AuthStatus.signedIn, session: Fixtures.session),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'signInRequested → failure is shown and the user stays signed out',
    setUp: () => when(signIn(any)).thenAnswer((_) async => left(const Failure.invalidInput(message: 'Bad email'))),
    build: build,
    seed: () => const AuthState(status: AuthStatus.signedOut),
    act: (bloc) => bloc.add(const AuthEvent.signInRequested('x')),
    expect: () => [
      const AuthState(status: AuthStatus.signedOut, isSubmitting: true),
      const AuthState(
        status: AuthStatus.signedOut,
        failure: Failure.invalidInput(message: 'Bad email'),
      ),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'ignores sign-in while one is already submitting',
    build: build,
    seed: () => const AuthState(status: AuthStatus.signedOut, isSubmitting: true),
    act: (bloc) => bloc.add(const AuthEvent.signInRequested('test@example.com')),
    expect: () => <AuthState>[],
    verify: (_) => verifyNever(signIn(any)),
  );

  blocTest<AuthBloc, AuthState>(
    'signOutRequested → signedOut',
    setUp: () => when(signOut(any)).thenAnswer((_) async => right(unit)),
    build: build,
    seed: () => const AuthState(status: AuthStatus.signedIn, session: Fixtures.session),
    act: (bloc) => bloc.add(const AuthEvent.signOutRequested()),
    expect: () => [const AuthState(status: AuthStatus.signedOut)],
  );

  blocTest<AuthBloc, AuthState>(
    'signOutRequested keeps the session and reports the failure',
    setUp: () => when(signOut(any)).thenAnswer((_) async => left(const Failure.cache())),
    build: build,
    seed: () => const AuthState(status: AuthStatus.signedIn, session: Fixtures.session),
    act: (bloc) => bloc.add(const AuthEvent.signOutRequested()),
    expect: () => [const AuthState(status: AuthStatus.signedIn, session: Fixtures.session, failure: Failure.cache())],
  );
}
