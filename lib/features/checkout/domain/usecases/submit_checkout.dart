import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../orders/domain/entities/order_placement.dart';
import '../../../orders/domain/usecases/create_order.dart';
import '../entities/checkout_draft.dart';
import '../repositories/checkout_repository.dart';

/// Turns a completed draft into an order.
///
/// 1. Marks the draft as "in flight" and saves it, so a refresh mid-request is
///    detected and retried with the same idempotency key.
/// 2. Places the order with the draft's key.
/// 3. On success, rotates to a new draft (new key) so the next checkout is a
///    new order; on failure, clears the in-flight flag so the customer can retry.
@lazySingleton
class SubmitCheckout implements UseCase<OrderPlacement, CheckoutDraft> {
  const SubmitCheckout(this._repository, this._createOrder);

  final CheckoutRepository _repository;
  final CreateOrder _createOrder;

  @override
  Future<Either<Failure, OrderPlacement>> call(CheckoutDraft draft) async {
    final slotId = draft.slotId;
    final paymentMethodId = draft.paymentMethodId;
    if (draft.serviceIds.isEmpty) {
      return left(const Failure.invalidInput(message: 'Select at least one service.'));
    }
    if (slotId == null) {
      return left(const Failure.invalidInput(message: 'Choose a time slot.'));
    }
    if (paymentMethodId == null) {
      return left(const Failure.invalidInput(message: 'Choose a payment method.'));
    }

    final inFlight = draft.copyWith(submissionInFlight: true);
    final saved = await _repository.saveDraft(inFlight);
    if (saved case Left(value: final failure)) return left(failure);

    final result = await _createOrder(
      CreateOrderParams(
        idempotencyKey: draft.idempotencyKey,
        serviceIds: draft.serviceIds,
        slotId: slotId,
        paymentMethodId: paymentMethodId,
      ),
    );

    await result.match(
      (_) => _repository.saveDraft(inFlight.copyWith(submissionInFlight: false)),
      (_) => _repository.startNewDraft(),
    );
    return result;
  }
}
