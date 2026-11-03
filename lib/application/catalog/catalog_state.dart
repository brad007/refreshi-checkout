part of 'catalog_bloc.dart';

@freezed
sealed class CatalogState with _$CatalogState {
  const factory CatalogState.initial() = CatalogInitial;
  const factory CatalogState.loading() = CatalogLoading;
  const factory CatalogState.loaded(CheckoutCatalog catalog) = CatalogLoaded;
  const factory CatalogState.failure(Failure failure) = CatalogFailure;
}
