import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/core/graphql/__generated/schema.graphql.dart';
import 'package:refreshi_checkout/features/catalog/data/graphql/__generated/catalog.graphql.dart';
import 'package:refreshi_checkout/features/orders/data/graphql/__generated/orders.graphql.dart';
import 'package:refreshi_checkout/features/orders/data/models/order_mappers.dart';
import 'package:refreshi_checkout/features/orders/domain/entities/order.dart';

void main() {
  final at = DateTime.utc(2030, 1, 1, 9);
  final fields = Fragment$OrderFields(
    id: 'ord_1',
    status: Enum$OrderStatus.CONFIRMED,
    items: [Fragment$OrderFields$items(serviceId: 's', name: 'S', priceCents: 100)],
    slot: Fragment$TimeSlotFields(id: 't', startsAt: at, endsAt: at),
    paymentMethod: Fragment$PaymentMethodFields(id: 'p', brand: 'Visa', last4: '4242'),
    totalCents: 100,
    currency: 'ZAR',
    hold: Fragment$OrderFields$hold(
      id: 'h',
      status: Enum$HoldStatus.PLACED,
      amountCents: 100,
      provider: 'PEACH_PAYMENTS',
      paymentType: 'PA',
      reference: 'ref',
      resultCode: '000.100.110',
      resultDescription: 'ok',
    ),
    timeline: [Fragment$OrderFields$timeline(type: Enum$TimelineEventType.HOLD_PLACED, at: at)],
    createdAt: at,
  );

  test('maps the generated order to the domain entity in local time', () {
    final order = fields.toEntity();
    expect(order.id, 'ord_1');
    expect(order.status, OrderStatus.confirmed);
    expect(order.items.single, const OrderItem(serviceId: 's', name: 'S', priceCents: 100));
    expect(
      order.hold,
      const PaymentHold(
        id: 'h',
        status: HoldStatus.placed,
        amountCents: 100,
        reference: 'ref',
        resultCode: '000.100.110',
        resultDescription: 'ok',
      ),
    );
    expect(order.timeline.single.type, TimelineEventType.holdPlaced);
    expect(order.createdAt, at.toLocal());
    expect(order.paymentMethod.last4, '4242');
    expect(order.isPending, isFalse);
  });

  test('maps the create payload', () {
    final placement = Mutation$CreateOrder$createOrder(order: fields, replayed: true).toEntity();
    expect(placement.replayed, isTrue);
    expect(placement.order.id, 'ord_1');
  });

  test('maps every enum value, treating unknown values as the safest state', () {
    expect(Enum$OrderStatus.values.map((e) => e.toEntity()), [
      OrderStatus.awaitingHold,
      OrderStatus.confirmed,
      OrderStatus.paymentFailed,
      OrderStatus.awaitingHold,
    ]);
    expect(Enum$HoldStatus.values.map((e) => e.toEntity()), [
      HoldStatus.pending,
      HoldStatus.placed,
      HoldStatus.failed,
      HoldStatus.pending,
    ]);
    expect(Enum$TimelineEventType.values.map((e) => e.toEntity()), [
      TimelineEventType.orderCreated,
      TimelineEventType.holdRequested,
      TimelineEventType.holdPlaced,
      TimelineEventType.holdFailed,
      TimelineEventType.orderCreated,
    ]);
  });
}
