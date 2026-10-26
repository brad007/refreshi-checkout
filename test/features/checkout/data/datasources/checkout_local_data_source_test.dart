import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/exceptions.dart';
import 'package:refreshi_checkout/features/checkout/data/datasources/checkout_local_data_source.dart';
import 'package:refreshi_checkout/features/checkout/data/models/checkout_draft_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.mocks.dart';

void main() {
  final model = CheckoutDraftModel.fromEntity(Fixtures.completeDraft);

  test('returns null when there is no draft', () async {
    SharedPreferences.setMockInitialValues({});
    expect(CheckoutLocalDataSourceImpl(await SharedPreferences.getInstance()).getDraft(), isNull);
  });

  test('round-trips a draft', () async {
    SharedPreferences.setMockInitialValues({});
    final dataSource = CheckoutLocalDataSourceImpl(await SharedPreferences.getInstance());
    await dataSource.saveDraft(model);
    expect(dataSource.getDraft(), model);
  });

  test('treats a corrupt draft as no draft', () async {
    SharedPreferences.setMockInitialValues({CheckoutLocalDataSourceImpl.storageKey: '{"bad":'});
    expect(CheckoutLocalDataSourceImpl(await SharedPreferences.getInstance()).getDraft(), isNull);
  });

  test('throws CacheException when the write is rejected', () {
    final prefs = MockSharedPreferences();
    when(prefs.setString(any, any)).thenAnswer((_) async => false);
    expect(() => CheckoutLocalDataSourceImpl(prefs).saveDraft(model), throwsA(isA<CacheException>()));
  });
}
