import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../core/usecase.dart';
import '../../domain/checkout/checkout_draft.dart';
import '../../domain/checkout/checkout_repository.dart';

@lazySingleton
class StartNewCheckout implements UseCase<CheckoutDraft, NoParams> {
  const StartNewCheckout(this._repository);

  final CheckoutRepository _repository;

  @override
  Future<Either<Failure, CheckoutDraft>> call(NoParams params) => _repository.startNewDraft();
}
