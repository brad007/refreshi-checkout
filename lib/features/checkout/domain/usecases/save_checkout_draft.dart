import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/checkout_draft.dart';
import '../repositories/checkout_repository.dart';

@lazySingleton
class SaveCheckoutDraft implements UseCase<Unit, CheckoutDraft> {
  const SaveCheckoutDraft(this._repository);

  final CheckoutRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(CheckoutDraft draft) => _repository.saveDraft(draft);
}
