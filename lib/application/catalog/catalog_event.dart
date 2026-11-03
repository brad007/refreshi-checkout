part of 'catalog_bloc.dart';

@freezed
sealed class CatalogEvent with _$CatalogEvent {
  const factory CatalogEvent.requested({@Default(false) bool forceRefresh}) = CatalogRequested;
}
