part of 'checkout_bloc.dart';

enum CheckoutStatus { loading, ready, submitting, success, failure }

@freezed
abstract class CheckoutState with _$CheckoutState {
  const CheckoutState._();

  const factory CheckoutState({
    @Default(CheckoutStatus.loading) CheckoutStatus status,
    CheckoutDraft? draft,
    Failure? failure,

    /// Set when an order was placed; the page navigates to it.
    OrderPlacement? placement,

    /// True when the submission was resumed automatically after a reload.
    @Default(false) bool resumed,
  }) = _CheckoutState;

  bool get isSubmitting => status == CheckoutStatus.submitting;

  /// This checkout's idempotency key already belongs to a different order, so
  /// resubmitting can only conflict again. The customer must view that order
  /// or start a new checkout.
  bool get isSpent => failure is IdempotencyConflictFailure;

  bool get canSubmit => !isSubmitting && !isSpent && (draft?.isComplete ?? false);
}
