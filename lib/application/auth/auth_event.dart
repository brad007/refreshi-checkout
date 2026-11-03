part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = AuthStarted;
  const factory AuthEvent.signInRequested(String email) = AuthSignInRequested;
  const factory AuthEvent.signOutRequested() = AuthSignOutRequested;
}
