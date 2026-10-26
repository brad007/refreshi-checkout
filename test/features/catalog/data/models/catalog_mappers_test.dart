import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/features/catalog/data/graphql/__generated/catalog.graphql.dart';
import 'package:refreshi_checkout/features/catalog/data/models/catalog_mappers.dart';
import 'package:refreshi_checkout/features/catalog/domain/entities/catalog_service.dart';
import 'package:refreshi_checkout/features/catalog/domain/entities/payment_method.dart';

void main() {
  final startsAt = DateTime.utc(2030, 1, 2, 8);
  final query = Query$CheckoutCatalog(
    services: [
      Fragment$ServiceFields(
        id: 's',
        name: 'S',
        storeName: 'Store',
        category: 'BAKERY',
        description: 'D',
        priceCents: 100,
        originalPriceCents: 300,
      ),
    ],
    availableSlots: [
      Fragment$TimeSlotFields(id: 't', startsAt: startsAt, endsAt: startsAt.add(const Duration(hours: 2))),
    ],
    paymentMethods: [Fragment$PaymentMethodFields(id: 'p', brand: 'Visa', last4: '4242')],
  );

  test('maps the generated query type to domain entities', () {
    final catalog = query.toEntity();
    expect(
      catalog.services.single,
      const CatalogService(
        id: 's',
        name: 'S',
        storeName: 'Store',
        category: 'BAKERY',
        description: 'D',
        priceCents: 100,
        originalPriceCents: 300,
      ),
    );
    expect(catalog.paymentMethods.single, const PaymentMethod(id: 'p', brand: 'Visa', last4: '4242'));
    final slot = catalog.slots.single;
    expect(slot.id, 't');
    expect(slot.startsAt.isUtc, isFalse, reason: 'slots are shown in local time');
    expect(slot.startsAt, startsAt.toLocal());
  });
}
