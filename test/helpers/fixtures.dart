import 'package:refreshi_checkout/features/auth/domain/entities/user_session.dart';
import 'package:refreshi_checkout/features/catalog/domain/entities/catalog_service.dart';
import 'package:refreshi_checkout/features/catalog/domain/entities/checkout_catalog.dart';
import 'package:refreshi_checkout/features/catalog/domain/entities/payment_method.dart';
import 'package:refreshi_checkout/features/catalog/domain/entities/time_slot.dart';
import 'package:refreshi_checkout/features/checkout/domain/entities/checkout_draft.dart';
import 'package:refreshi_checkout/features/orders/domain/entities/order.dart';
import 'package:refreshi_checkout/features/orders/domain/entities/order_placement.dart';

/// Shared test data. Kept as plain constants/functions so every test reads
/// the same values and assertions stay short.
abstract final class Fixtures {
  static const session = UserSession(email: 'test@example.com');

  static const bakery = CatalogService(
    id: 'bag_bakery',
    name: 'Bakery rescue bag',
    storeName: 'Knead Bakery',
    category: 'BAKERY',
    description: 'Loaves and pastries',
    priceCents: 6500,
    originalPriceCents: 19500,
  );

  static const produce = CatalogService(
    id: 'bag_grocer',
    name: 'Fresh produce box',
    storeName: 'Harvest Grocer',
    category: 'GROCERY',
    description: 'Fruit and veg',
    priceCents: 8900,
    originalPriceCents: 26000,
  );

  static const cafe = CatalogService(
    id: 'bag_cafe',
    name: 'Café surprise bag',
    storeName: 'Origin Coffee',
    category: 'CAFE',
    description: 'Sandwiches and treats',
    priceCents: 5500,
    originalPriceCents: 16000,
  );

  static final slot = TimeSlot(id: 'slot_1', startsAt: DateTime(2030, 1, 2, 10), endsAt: DateTime(2030, 1, 2, 12));

  static final slotNextDay = TimeSlot(
    id: 'slot_2',
    startsAt: DateTime(2030, 1, 3, 14),
    endsAt: DateTime(2030, 1, 3, 16),
  );

  // Peach Payments registration tokens.
  static const visa = PaymentMethod(id: '8ac7a4a28a5f1e3c018a6b2e0d7f4a01', brand: 'Visa', last4: '0000');

  static const mastercard = PaymentMethod(id: '8ac7a4a28a5f1e3c018a6b2e0d7f4b07', brand: 'Mastercard', last4: '5454');

  static final catalog = CheckoutCatalog(
    services: const [bakery, produce, cafe],
    slots: [slot, slotNextDay],
    paymentMethods: const [visa, mastercard],
  );

  static const emptyDraft = CheckoutDraft(idempotencyKey: 'key-1');

  static final completeDraft = CheckoutDraft(
    idempotencyKey: 'key-1',
    serviceIds: const ['bag_bakery', 'bag_grocer'],
    slotId: slot.id,
    paymentMethodId: visa.id,
  );

  static CustomerOrder order({String id = 'ord_1', HoldStatus hold = HoldStatus.pending}) {
    final createdAt = DateTime(2030, 1, 1, 9);
    return CustomerOrder(
      id: id,
      status: switch (hold) {
        HoldStatus.pending => OrderStatus.awaitingHold,
        HoldStatus.placed => OrderStatus.confirmed,
        HoldStatus.failed => OrderStatus.paymentFailed,
      },
      items: const [
        OrderItem(serviceId: 'bag_bakery', name: 'Bakery rescue bag', priceCents: 6500),
        OrderItem(serviceId: 'bag_grocer', name: 'Fresh produce box', priceCents: 8900),
      ],
      slot: slot,
      paymentMethod: visa,
      totalCents: 15400,
      currency: 'ZAR',
      hold: PaymentHold(
        id: 'hold_1',
        status: hold,
        amountCents: 15400,
        reference: '8ac7a4a289d210fc0189d5b4e9572cc8',
        resultCode: switch (hold) {
          HoldStatus.pending => '000.200.000',
          HoldStatus.placed => '000.100.110',
          HoldStatus.failed => '800.100.203',
        },
        resultDescription: switch (hold) {
          HoldStatus.pending => 'transaction pending',
          HoldStatus.placed => "Request successfully processed in 'Merchant in Integrator Test Mode'",
          HoldStatus.failed => 'Insufficient Funds',
        },
      ),
      timeline: [
        TimelineEvent(type: TimelineEventType.orderCreated, at: createdAt),
        TimelineEvent(type: TimelineEventType.holdRequested, at: createdAt),
        if (hold == HoldStatus.placed)
          TimelineEvent(type: TimelineEventType.holdPlaced, at: createdAt.add(const Duration(seconds: 3))),
        if (hold == HoldStatus.failed)
          TimelineEvent(type: TimelineEventType.holdFailed, at: createdAt.add(const Duration(seconds: 3))),
      ],
      createdAt: createdAt,
    );
  }

  static OrderPlacement placement({bool replayed = false}) => OrderPlacement(order: order(), replayed: replayed);
}
