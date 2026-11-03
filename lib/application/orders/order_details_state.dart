part of 'order_details_bloc.dart';

enum OrderDetailsStatus { loading, loaded, failure }

@freezed
abstract class OrderDetailsState with _$OrderDetailsState {
  const factory OrderDetailsState({
    @Default(OrderDetailsStatus.loading) OrderDetailsStatus status,
    CustomerOrder? order,
    Failure? failure,

    /// True while subscribed to live updates for a pending hold.
    @Default(false) bool isLive,
    Failure? liveUpdateFailure,
  }) = _OrderDetailsState;
}
