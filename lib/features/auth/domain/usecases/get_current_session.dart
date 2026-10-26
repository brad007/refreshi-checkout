import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_session.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class GetCurrentSession implements UseCase<Option<UserSession>, NoParams> {
  const GetCurrentSession(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, Option<UserSession>>> call(NoParams params) => _repository.currentSession();
}
