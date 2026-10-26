import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/features/orders/domain/entities/order.dart';
import 'package:refreshi_checkout/features/orders/presentation/bloc/order_details_bloc.dart';

import '../../../../helpers/dummies.dart';
import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockGetOrder getOrder;
  late MockWatchOrder watchOrder;

  setUpAll(registerDummies);

  setUp(() {
    getOrder = MockGetOrder();
    watchOrder = MockWatchOrder();
  });

  OrderDetailsBloc build() => OrderDetailsBloc(getOrder, watchOrder);

  final pending = Fixtures.order();
  final placed = Fixtures.order(hold: HoldStatus.placed);

  blocTest<OrderDetailsBloc, OrderDetailsState>(
    'a pending order is shown, then followed live until the hold is placed',
    setUp: () {
      when(getOrder(any)).thenAnswer((_) async => right(pending));
      when(watchOrder(any)).thenAnswer((_) => Stream.fromIterable([right(pending), right(placed)]));
    },
    build: build,
    act: (bloc) => bloc.add(const OrderDetailsEvent.started('ord_1')),
    expect: () => [
      const OrderDetailsState(),
      OrderDetailsState(status: OrderDetailsStatus.loaded, order: pending, isLive: true),
      OrderDetailsState(status: OrderDetailsStatus.loaded, order: placed),
    ],
  );

  blocTest<OrderDetailsBloc, OrderDetailsState>(
    'a settled order is shown without subscribing',
    setUp: () => when(getOrder(any)).thenAnswer((_) async => right(placed)),
    build: build,
    act: (bloc) => bloc.add(const OrderDetailsEvent.started('ord_1')),
    expect: () => [const OrderDetailsState(), OrderDetailsState(status: OrderDetailsStatus.loaded, order: placed)],
    verify: (_) => verifyNever(watchOrder(any)),
  );

  blocTest<OrderDetailsBloc, OrderDetailsState>(
    'a missing order is a failure',
    setUp: () => when(getOrder(any)).thenAnswer((_) async => left(const Failure.notFound())),
    build: build,
    act: (bloc) => bloc.add(const OrderDetailsEvent.started('nope')),
    expect: () => [
      const OrderDetailsState(),
      const OrderDetailsState(status: OrderDetailsStatus.failure, failure: Failure.notFound()),
    ],
  );

  blocTest<OrderDetailsBloc, OrderDetailsState>(
    'a live-update failure keeps the last order and stops being live',
    setUp: () {
      when(getOrder(any)).thenAnswer((_) async => right(pending));
      when(watchOrder(any)).thenAnswer((_) => Stream.value(left(const Failure.network())));
    },
    build: build,
    act: (bloc) => bloc.add(const OrderDetailsEvent.started('ord_1')),
    expect: () => [
      const OrderDetailsState(),
      OrderDetailsState(status: OrderDetailsStatus.loaded, order: pending, isLive: true),
      OrderDetailsState(status: OrderDetailsStatus.loaded, order: pending, liveUpdateFailure: const Failure.network()),
    ],
  );

  blocTest<OrderDetailsBloc, OrderDetailsState>(
    'stops being live if the subscription ends while still pending',
    setUp: () {
      when(getOrder(any)).thenAnswer((_) async => right(pending));
      when(watchOrder(any)).thenAnswer((_) => const Stream.empty());
    },
    build: build,
    act: (bloc) => bloc.add(const OrderDetailsEvent.started('ord_1')),
    expect: () => [
      const OrderDetailsState(),
      OrderDetailsState(status: OrderDetailsStatus.loaded, order: pending, isLive: true),
      OrderDetailsState(status: OrderDetailsStatus.loaded, order: pending),
    ],
  );
}
