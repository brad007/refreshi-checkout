import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/application/core/usecase.dart';
import 'package:refreshi_checkout/application/catalog/get_checkout_catalog.dart';

import '../../helpers/dummies.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/mocks.mocks.dart';

void main() {
  setUpAll(registerDummies);

  test('asks for the booking window', () async {
    final repository = MockCatalogRepository();
    when(repository.getCheckoutCatalog(days: anyNamed('days'))).thenAnswer((_) async => right(Fixtures.catalog));

    expect(await GetCheckoutCatalog(repository)(const NoParams()), right(Fixtures.catalog));
    verify(repository.getCheckoutCatalog(days: GetCheckoutCatalog.bookingWindowDays));
  });
}
