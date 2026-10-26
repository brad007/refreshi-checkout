import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/exceptions.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/features/catalog/data/graphql/__generated/catalog.graphql.dart';
import 'package:refreshi_checkout/features/catalog/data/repositories/catalog_repository_impl.dart';

import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockCatalogRemoteDataSource remote;
  late CatalogRepositoryImpl repository;

  setUp(() {
    remote = MockCatalogRemoteDataSource();
    repository = CatalogRepositoryImpl(remote);
  });

  test('maps the response to a CheckoutCatalog', () async {
    when(remote.getCheckoutCatalog(days: anyNamed('days'))).thenAnswer(
      (_) async => Query$CheckoutCatalog(
        services: [
          Fragment$ServiceFields(
            id: 's',
            name: 'S',
            storeName: 'Store',
            category: 'BAKERY',
            description: 'D',
            priceCents: 1,
            originalPriceCents: 300,
          ),
        ],
        availableSlots: const [],
        paymentMethods: const [],
      ),
    );
    final result = await repository.getCheckoutCatalog(days: 7);
    expect(result.toNullable()!.services.single.id, 's');
    verify(remote.getCheckoutCatalog(days: 7));
  });

  test('maps exceptions to failures', () async {
    when(remote.getCheckoutCatalog(days: anyNamed('days'))).thenThrow(const NetworkException());
    final result = await repository.getCheckoutCatalog(days: 7);
    expect(result.getLeft().toNullable(), const Failure.network());
  });
}
