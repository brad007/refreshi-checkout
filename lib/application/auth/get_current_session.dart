import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../core/usecase.dart';
import '../../domain/auth/user_session.dart';
import '../../domain/auth/auth_repository.dart';

@lazySingleton
class GetCurrentSession implements UseCase<Option<UserSession>, NoParams> {
  const GetCurrentSession(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, Option<UserSession>>> call(NoParams params) => _repository.currentSession();
}
