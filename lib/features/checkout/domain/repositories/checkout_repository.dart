import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/checkout_draft.dart';

abstract interface class CheckoutRepository {
  /// Returns the saved draft, or starts (and saves) a new one.
  Future<Either<Failure, CheckoutDraft>> loadDraft();

  Future<Either<Failure, Unit>> saveDraft(CheckoutDraft draft);

  /// Discards the current draft and starts a new one with a fresh key.
  Future<Either<Failure, CheckoutDraft>> startNewDraft();
}
