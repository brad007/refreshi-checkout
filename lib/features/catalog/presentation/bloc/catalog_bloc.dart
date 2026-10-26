import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/checkout_catalog.dart';
import '../../domain/usecases/get_checkout_catalog.dart';

part 'catalog_bloc.freezed.dart';
part 'catalog_event.dart';
part 'catalog_state.dart';

/// App-wide so the catalog page and the checkout page share one load.
@lazySingleton
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc(this._getCheckoutCatalog) : super(const CatalogState.initial()) {
    on<CatalogRequested>(_onRequested, transformer: droppable());
  }

  final GetCheckoutCatalog _getCheckoutCatalog;

  Future<void> _onRequested(CatalogRequested event, Emitter<CatalogState> emit) async {
    if (state is CatalogLoaded && !event.forceRefresh) return;
    emit(const CatalogState.loading());
    final result = await _getCheckoutCatalog(const NoParams());
    emit(result.match(CatalogState.failure, CatalogState.loaded));
  }
}
