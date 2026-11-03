part of 'checkout_bloc.dart';

@freezed
sealed class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = CheckoutStarted;
  const factory CheckoutEvent.serviceToggled(String serviceId) = CheckoutServiceToggled;
  const factory CheckoutEvent.slotSelected(String slotId) = CheckoutSlotSelected;
  const factory CheckoutEvent.paymentMethodSelected(String paymentMethodId) = CheckoutPaymentMethodSelected;

  /// Drops selections that are no longer offered (e.g. a saved slot that has
  /// passed since the draft was stored).
  const factory CheckoutEvent.catalogAvailable(CheckoutCatalog catalog) = CheckoutCatalogAvailable;
  const factory CheckoutEvent.submitted() = CheckoutSubmitted;
  const factory CheckoutEvent.newCheckoutRequested() = CheckoutNewCheckoutRequested;

  /// Starts a new checkout (new idempotency key) with the bags and pickup
  /// window of an order whose payment failed, so only the card needs changing.
  const factory CheckoutEvent.retryRequested({required List<String> serviceIds, String? slotId}) =
      CheckoutRetryRequested;

  /// The UI has navigated to the placed order; clear it so it isn't handled twice.
  const factory CheckoutEvent.placementHandled() = CheckoutPlacementHandled;
}
