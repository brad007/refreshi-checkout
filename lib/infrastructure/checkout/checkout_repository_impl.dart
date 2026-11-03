import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../core/id_generator.dart';
import '../core/exception_mapper.dart';
import '../../domain/core/failures.dart';
import '../../domain/checkout/checkout_draft.dart';
import '../../domain/checkout/checkout_repository.dart';
import 'checkout_local_data_source.dart';
import 'checkout_draft_model.dart';

@LazySingleton(as: CheckoutRepository)
class CheckoutRepositoryImpl implements CheckoutRepository {
  const CheckoutRepositoryImpl(this._local, this._newKey);

  final CheckoutLocalDataSource _local;
  final IdGenerator _newKey;

  @override
  Future<Either<Failure, CheckoutDraft>> loadDraft() async {
    final saved = _local.getDraft();
    if (saved != null) return right(saved.toEntity());
    return startNewDraft();
  }

  @override
  Future<Either<Failure, Unit>> saveDraft(CheckoutDraft draft) async {
    try {
      await _local.saveDraft(CheckoutDraftModel.fromEntity(draft));
      return right(unit);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, CheckoutDraft>> startNewDraft() async {
    final draft = CheckoutDraft(idempotencyKey: _newKey());
    return (await saveDraft(draft)).map((_) => draft);
  }
}
