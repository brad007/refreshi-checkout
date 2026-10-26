import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_session_model.dart';

abstract interface class AuthLocalDataSource {
  /// Returns the saved session or null. Throws [CacheException] if unreadable.
  UserSessionModel? getSession();

  Future<void> saveSession(UserSessionModel session);

  Future<void> clearSession();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this._prefs);

  static const storageKey = 'auth.session.v1';

  final SharedPreferences _prefs;

  @override
  UserSessionModel? getSession() {
    final raw = _prefs.getString(storageKey);
    if (raw == null) return null;
    try {
      return UserSessionModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object catch (e) {
      throw CacheException('Unreadable session: $e');
    }
  }

  @override
  Future<void> saveSession(UserSessionModel session) async {
    final ok = await _prefs.setString(storageKey, jsonEncode(session.toJson()));
    if (!ok) throw const CacheException('Could not save session');
  }

  @override
  Future<void> clearSession() async {
    await _prefs.remove(storageKey);
  }
}
