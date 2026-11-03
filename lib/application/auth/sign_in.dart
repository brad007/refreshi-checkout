import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../core/usecase.dart';
import '../../domain/auth/user_session.dart';
import '../../domain/auth/auth_repository.dart';

@lazySingleton
class SignIn implements UseCase<UserSession, String> {
  const SignIn(this._repository);

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  final AuthRepository _repository;

  @override
  Future<Either<Failure, UserSession>> call(String email) async {
    final trimmed = email.trim();
    if (!_emailPattern.hasMatch(trimmed)) {
      return left(const Failure.invalidInput(message: 'Enter a valid email address.'));
    }
    return _repository.signIn(email: trimmed.toLowerCase());
  }
}
