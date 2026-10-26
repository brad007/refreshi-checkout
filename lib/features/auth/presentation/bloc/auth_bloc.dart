import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/user_session.dart';
import '../../domain/usecases/get_current_session.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_out.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._getCurrentSession, this._signIn, this._signOut) : super(const AuthState()) {
    on<AuthStarted>(_onStarted);
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
  }

  final GetCurrentSession _getCurrentSession;
  final SignIn _signIn;
  final SignOut _signOut;

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    final result = await _getCurrentSession(const NoParams());
    emit(
      result.match(
        (_) => const AuthState(status: AuthStatus.signedOut),
        (session) => session.match(
          () => const AuthState(status: AuthStatus.signedOut),
          (s) => AuthState(status: AuthStatus.signedIn, session: s),
        ),
      ),
    );
  }

  Future<void> _onSignInRequested(AuthSignInRequested event, Emitter<AuthState> emit) async {
    if (state.isSubmitting) return;
    emit(state.copyWith(isSubmitting: true, failure: null));
    final result = await _signIn(event.email);
    emit(
      result.match(
        (failure) => state.copyWith(isSubmitting: false, failure: failure),
        (session) => AuthState(status: AuthStatus.signedIn, session: session),
      ),
    );
  }

  Future<void> _onSignOutRequested(AuthSignOutRequested event, Emitter<AuthState> emit) async {
    final result = await _signOut(const NoParams());
    result.match(
      (failure) => emit(state.copyWith(failure: failure)),
      (_) => emit(const AuthState(status: AuthStatus.signedOut)),
    );
  }
}
