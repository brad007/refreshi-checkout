import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_draft.freezed.dart';

/// The customer's in-progress checkout. It is persisted on every change, so a
/// refresh resumes exactly where the customer was.
///
/// [idempotencyKey] is created with the draft and sent with every attempt to
/// place this order, so retries can never create a second order or hold.
@freezed
abstract class CheckoutDraft with _$CheckoutDraft {
  const CheckoutDraft._();

  static const maxServices = 2;

  const factory CheckoutDraft({
    required String idempotencyKey,
    @Default([]) List<String> serviceIds,
    String? slotId,
    String? paymentMethodId,

    /// Set just before the order request is sent and cleared when it settles.
    /// If the page reloads while this is true the outcome is unknown, so the
    /// checkout resubmits with the same key, which is safe.
    @Default(false) bool submissionInFlight,
  }) = _CheckoutDraft;

  bool get isEmpty => serviceIds.isEmpty;

  bool get canAddMoreServices => serviceIds.length < maxServices;

  bool get isComplete => serviceIds.isNotEmpty && slotId != null && paymentMethodId != null;

  CheckoutDraft toggleService(String serviceId) {
    if (serviceIds.contains(serviceId)) {
      return copyWith(serviceIds: [...serviceIds]..remove(serviceId));
    }
    if (!canAddMoreServices) return this;
    return copyWith(serviceIds: [...serviceIds, serviceId]);
  }
}
