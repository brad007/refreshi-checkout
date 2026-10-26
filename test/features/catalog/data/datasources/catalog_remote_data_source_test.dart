import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/core/error/exceptions.dart';
import 'package:refreshi_checkout/core/graphql/local/seed_data.dart';
import 'package:refreshi_checkout/features/catalog/data/datasources/catalog_remote_data_source.dart';

import '../../../../helpers/local_api.dart';

void main() {
  late LocalApi api;
  late CatalogRemoteDataSourceImpl dataSource;

  setUp(() async {
    api = await LocalApi.create();
    dataSource = CatalogRemoteDataSourceImpl(api.client);
  });

  tearDown(() => api.dispose());

  test('fetches services, slots and payment methods as typed data', () async {
    final result = await dataSource.getCheckoutCatalog(days: 3);
    expect(result.services.map((s) => s.id), SeedData.services.map((s) => s['id']));
    expect(result.services.first.priceCents, 6500);
    expect(result.services.first.originalPriceCents, 19500);
    expect(result.services.first.storeName, isNotEmpty);
    expect(result.paymentMethods.map((p) => p.last4), ['0000', '5454', '8079']);
    expect(result.availableSlots, isNotEmpty);
    expect(result.availableSlots.first.startsAt, isA<DateTime>());
  });

  test('surfaces GraphQL errors as ServerException', () async {
    expect(
      () => dataSource.getCheckoutCatalog(days: 99),
      throwsA(isA<ServerException>().having((e) => e.code, 'code', ErrorCodes.badUserInput)),
    );
  });
}
