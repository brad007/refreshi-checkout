import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_session.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Option<UserSession>>> currentSession();

  Future<Either<Failure, UserSession>> signIn({required String email});

  Future<Either<Failure, Unit>> signOut();
}
