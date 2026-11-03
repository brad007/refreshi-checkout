import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/failures.dart';
import '../core/usecase.dart';
import '../../domain/checkout/checkout_draft.dart';
import '../../domain/checkout/checkout_repository.dart';

@lazySingleton
class SaveCheckoutDraft implements UseCase<Unit, CheckoutDraft> {
  const SaveCheckoutDraft(this._repository);

  final CheckoutRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(CheckoutDraft draft) => _repository.saveDraft(draft);
}
