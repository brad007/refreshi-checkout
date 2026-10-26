import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/exceptions.dart';
import 'package:refreshi_checkout/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:refreshi_checkout/features/auth/data/models/user_session_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/mocks.mocks.dart';

void main() {
  const model = UserSessionModel(email: 'test@example.com');

  group('with real storage', () {
    late AuthLocalDataSourceImpl dataSource;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      dataSource = AuthLocalDataSourceImpl(await SharedPreferences.getInstance());
    });

    test('returns null when nothing is saved', () {
      expect(dataSource.getSession(), isNull);
    });

    test('round-trips a saved session', () async {
      await dataSource.saveSession(model);
      expect(dataSource.getSession(), model);
    });

    test('clears the session', () async {
      await dataSource.saveSession(model);
      await dataSource.clearSession();
      expect(dataSource.getSession(), isNull);
    });

    test('throws CacheException for unreadable data', () async {
      SharedPreferences.setMockInitialValues({AuthLocalDataSourceImpl.storageKey: 'nope'});
      final corrupt = AuthLocalDataSourceImpl(await SharedPreferences.getInstance());
      expect(corrupt.getSession, throwsA(isA<CacheException>()));
    });
  });

  test('throws CacheException when the write is rejected', () async {
    final prefs = MockSharedPreferences();
    when(prefs.setString(any, any)).thenAnswer((_) async => false);
    expect(() => AuthLocalDataSourceImpl(prefs).saveSession(model), throwsA(isA<CacheException>()));
  });
}
