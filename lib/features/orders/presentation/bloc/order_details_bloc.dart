import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/order.dart';
import '../../domain/usecases/get_order.dart';
import '../../domain/usecases/watch_order.dart';

part 'order_details_bloc.freezed.dart';
part 'order_details_event.dart';
part 'order_details_state.dart';

/// Fetches the order, then, if the payment hold is still pending, follows the
/// live subscription until it settles. Works the same on a cold deep link or
/// a refresh because everything comes from the order id in the URL.
@injectable
class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsBloc(this._getOrder, this._watchOrder) : super(const OrderDetailsState()) {
    on<OrderDetailsStarted>(_onStarted, transformer: restartable());
  }

  final GetOrder _getOrder;
  final WatchOrder _watchOrder;

  Future<void> _onStarted(OrderDetailsStarted event, Emitter<OrderDetailsState> emit) async {
    emit(state.copyWith(status: OrderDetailsStatus.loading, failure: null));
    final result = await _getOrder(event.orderId);

    final CustomerOrder order;
    switch (result) {
      case Left(value: final failure):
        emit(state.copyWith(status: OrderDetailsStatus.failure, failure: failure));
        return;
      case Right(value: final loaded):
        order = loaded;
    }

    emit(OrderDetailsState(status: OrderDetailsStatus.loaded, order: order, isLive: order.isPending));
    if (!order.isPending) return;

    await emit.forEach(
      _watchOrder(event.orderId),
      onData: (update) => update.match(
        // Keep showing what we have; the page offers a manual refresh.
        (failure) => state.copyWith(isLive: false, liveUpdateFailure: failure),
        (order) => state.copyWith(order: order, isLive: order.isPending),
      ),
    );
    if (state.isLive) emit(state.copyWith(isLive: false));
  }
}
