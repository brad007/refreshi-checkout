import 'package:freezed_annotation/freezed_annotation.dart';

import 'catalog_service.dart';
import 'payment_method.dart';
import 'time_slot.dart';

part 'checkout_catalog.freezed.dart';

/// Everything a customer can choose from during checkout, fetched in one query.
@freezed
abstract class CheckoutCatalog with _$CheckoutCatalog {
  const CheckoutCatalog._();

  const factory CheckoutCatalog({
    required List<CatalogService> services,
    required List<TimeSlot> slots,
    required List<PaymentMethod> paymentMethods,
  }) = _CheckoutCatalog;

  CatalogService? serviceById(String id) => services.where((s) => s.id == id).firstOrNull;

  TimeSlot? slotById(String? id) => slots.where((s) => s.id == id).firstOrNull;

  PaymentMethod? paymentMethodById(String? id) => paymentMethods.where((p) => p.id == id).firstOrNull;
}
