import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/features/catalog/presentation/bloc/catalog_bloc.dart';

import '../../../../helpers/dummies.dart';
import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockGetCheckoutCatalog getCatalog;

  setUpAll(registerDummies);
  setUp(() => getCatalog = MockGetCheckoutCatalog());

  blocTest<CatalogBloc, CatalogState>(
    'requested → loading → loaded',
    setUp: () => when(getCatalog(any)).thenAnswer((_) async => right(Fixtures.catalog)),
    build: () => CatalogBloc(getCatalog),
    act: (bloc) => bloc.add(const CatalogEvent.requested()),
    expect: () => [const CatalogState.loading(), CatalogState.loaded(Fixtures.catalog)],
  );

  blocTest<CatalogBloc, CatalogState>(
    'requested → loading → failure',
    setUp: () => when(getCatalog(any)).thenAnswer((_) async => left(const Failure.network())),
    build: () => CatalogBloc(getCatalog),
    act: (bloc) => bloc.add(const CatalogEvent.requested()),
    expect: () => [const CatalogState.loading(), const CatalogState.failure(Failure.network())],
  );

  blocTest<CatalogBloc, CatalogState>(
    'does not reload once loaded',
    build: () => CatalogBloc(getCatalog),
    seed: () => CatalogState.loaded(Fixtures.catalog),
    act: (bloc) => bloc.add(const CatalogEvent.requested()),
    expect: () => <CatalogState>[],
    verify: (_) => verifyNever(getCatalog(any)),
  );

  blocTest<CatalogBloc, CatalogState>(
    'reloads when forced',
    setUp: () => when(getCatalog(any)).thenAnswer((_) async => right(Fixtures.catalog)),
    build: () => CatalogBloc(getCatalog),
    seed: () => CatalogState.loaded(Fixtures.catalog),
    act: (bloc) => bloc.add(const CatalogEvent.requested(forceRefresh: true)),
    expect: () => [const CatalogState.loading(), CatalogState.loaded(Fixtures.catalog)],
  );

  blocTest<CatalogBloc, CatalogState>(
    'drops concurrent requests while one is loading',
    setUp: () => when(getCatalog(any)).thenAnswer((_) async => right(Fixtures.catalog)),
    build: () => CatalogBloc(getCatalog),
    act: (bloc) => bloc
      ..add(const CatalogEvent.requested())
      ..add(const CatalogEvent.requested()),
    expect: () => [const CatalogState.loading(), CatalogState.loaded(Fixtures.catalog)],
    verify: (_) => verify(getCatalog(any)).called(1),
  );
}
