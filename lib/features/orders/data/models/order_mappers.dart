import '../../../../core/graphql/__generated/schema.graphql.dart';
import '../../../catalog/data/models/catalog_mappers.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_placement.dart';
import '../graphql/__generated/orders.graphql.dart';

extension OrderFieldsMapper on Fragment$OrderFields {
  CustomerOrder toEntity() => CustomerOrder(
    id: id,
    status: status.toEntity(),
    items: [
      for (final item in items) OrderItem(serviceId: item.serviceId, name: item.name, priceCents: item.priceCents),
    ],
    slot: slot.toEntity(),
    paymentMethod: paymentMethod.toEntity(),
    totalCents: totalCents,
    currency: currency,
    hold: PaymentHold(
      id: hold.id,
      status: hold.status.toEntity(),
      amountCents: hold.amountCents,
      provider: hold.provider,
      paymentType: hold.paymentType,
      reference: hold.reference,
      resultCode: hold.resultCode,
      resultDescription: hold.resultDescription,
    ),
    timeline: [for (final event in timeline) TimelineEvent(type: event.type.toEntity(), at: event.at.toLocal())],
    createdAt: createdAt.toLocal(),
  );
}

extension CreateOrderPayloadMapper on Mutation$CreateOrder$createOrder {
  OrderPlacement toEntity() => OrderPlacement(order: order.toEntity(), replayed: replayed);
}

// `$unknown` is generated for forward compatibility: a newer server may send a
// value this build doesn't know. Map it to the safest interpretation.

extension OrderStatusMapper on Enum$OrderStatus {
  OrderStatus toEntity() => switch (this) {
    Enum$OrderStatus.AWAITING_HOLD || Enum$OrderStatus.$unknown => OrderStatus.awaitingHold,
    Enum$OrderStatus.CONFIRMED => OrderStatus.confirmed,
    Enum$OrderStatus.PAYMENT_FAILED => OrderStatus.paymentFailed,
  };
}

extension HoldStatusMapper on Enum$HoldStatus {
  HoldStatus toEntity() => switch (this) {
    Enum$HoldStatus.PENDING || Enum$HoldStatus.$unknown => HoldStatus.pending,
    Enum$HoldStatus.PLACED => HoldStatus.placed,
    Enum$HoldStatus.FAILED => HoldStatus.failed,
  };
}

extension TimelineEventTypeMapper on Enum$TimelineEventType {
  TimelineEventType toEntity() => switch (this) {
    Enum$TimelineEventType.ORDER_CREATED || Enum$TimelineEventType.$unknown => TimelineEventType.orderCreated,
    Enum$TimelineEventType.HOLD_REQUESTED => TimelineEventType.holdRequested,
    Enum$TimelineEventType.HOLD_PLACED => TimelineEventType.holdPlaced,
    Enum$TimelineEventType.HOLD_FAILED => TimelineEventType.holdFailed,
  };
}
