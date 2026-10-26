import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/checkout_draft.dart';
import '../repositories/checkout_repository.dart';

@lazySingleton
class StartNewCheckout implements UseCase<CheckoutDraft, NoParams> {
  const StartNewCheckout(this._repository);

  final CheckoutRepository _repository;

  @override
  Future<Either<Failure, CheckoutDraft>> call(NoParams params) => _repository.startNewDraft();
}
