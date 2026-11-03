part of 'order_details_bloc.dart';

@freezed
sealed class OrderDetailsEvent with _$OrderDetailsEvent {
  const factory OrderDetailsEvent.started(String orderId) = OrderDetailsStarted;
}
