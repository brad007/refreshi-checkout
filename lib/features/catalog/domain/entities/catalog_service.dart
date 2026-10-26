import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_service.freezed.dart';

/// A rescue bag of surplus food from a partner store. The brief calls these
/// "services"; named `CatalogService` to avoid clashing with the many
/// "service" classes in Flutter and DI code.
@freezed
abstract class CatalogService with _$CatalogService {
  const CatalogService._();

  const factory CatalogService({
    required String id,
    required String name,
    required String storeName,
    required String category,
    required String description,
    required int priceCents,
    required int originalPriceCents,
  }) = _CatalogService;

  int get savingsCents => originalPriceCents - priceCents;

  /// Whole-number discount, e.g. 67 for "67% off".
  int get savingsPercent => originalPriceCents == 0 ? 0 : (savingsCents * 100 / originalPriceCents).round();
}
