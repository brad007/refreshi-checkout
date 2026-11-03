import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../core/exception_mapper.dart';
import '../../domain/core/failures.dart';
import '../../domain/auth/user_session.dart';
import '../../domain/auth/auth_repository.dart';
import 'auth_local_data_source.dart';
import 'user_session_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._local);

  final AuthLocalDataSource _local;

  @override
  Future<Either<Failure, Option<UserSession>>> currentSession() async {
    try {
      return right(Option.fromNullable(_local.getSession()?.toEntity()));
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, UserSession>> signIn({required String email}) async {
    try {
      final session = UserSession(email: email);
      await _local.saveSession(UserSessionModel.fromEntity(session));
      return right(session);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await _local.clearSession();
      return right(unit);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
