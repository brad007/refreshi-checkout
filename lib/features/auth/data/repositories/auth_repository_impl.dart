import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exception_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../models/user_session_model.dart';

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
