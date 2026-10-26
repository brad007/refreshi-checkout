import '../../domain/entities/catalog_service.dart';
import '../../domain/entities/checkout_catalog.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/entities/time_slot.dart';
import '../graphql/__generated/catalog.graphql.dart';

// Generated GraphQL types are the data-layer models; these extensions map
// them to domain entities so nothing above the data layer imports them.

extension ServiceFieldsMapper on Fragment$ServiceFields {
  CatalogService toEntity() => CatalogService(
    id: id,
    name: name,
    storeName: storeName,
    category: category,
    description: description,
    priceCents: priceCents,
    originalPriceCents: originalPriceCents,
  );
}

extension TimeSlotFieldsMapper on Fragment$TimeSlotFields {
  TimeSlot toEntity() => TimeSlot(id: id, startsAt: startsAt.toLocal(), endsAt: endsAt.toLocal());
}

extension PaymentMethodFieldsMapper on Fragment$PaymentMethodFields {
  PaymentMethod toEntity() => PaymentMethod(id: id, brand: brand, last4: last4);
}

extension CheckoutCatalogQueryMapper on Query$CheckoutCatalog {
  CheckoutCatalog toEntity() => CheckoutCatalog(
    services: [for (final s in services) s.toEntity()],
    slots: [for (final s in availableSlots) s.toEntity()],
    paymentMethods: [for (final p in paymentMethods) p.toEntity()],
  );
}
