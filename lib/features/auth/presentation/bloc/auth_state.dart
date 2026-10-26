part of 'auth_bloc.dart';

enum AuthStatus { unknown, signedIn, signedOut }

@freezed
abstract class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    @Default(AuthStatus.unknown) AuthStatus status,
    UserSession? session,
    @Default(false) bool isSubmitting,
    Failure? failure,
  }) = _AuthState;

  bool get isSignedIn => status == AuthStatus.signedIn;
}
