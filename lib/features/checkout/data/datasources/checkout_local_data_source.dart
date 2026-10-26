import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/checkout_draft_model.dart';

abstract interface class CheckoutLocalDataSource {
  /// Returns the saved draft, or null if there is none or it is unreadable.
  CheckoutDraftModel? getDraft();

  Future<void> saveDraft(CheckoutDraftModel draft);
}

@LazySingleton(as: CheckoutLocalDataSource)
class CheckoutLocalDataSourceImpl implements CheckoutLocalDataSource {
  const CheckoutLocalDataSourceImpl(this._prefs);

  static const storageKey = 'checkout.draft.v1';

  final SharedPreferences _prefs;

  @override
  CheckoutDraftModel? getDraft() {
    final raw = _prefs.getString(storageKey);
    if (raw == null) return null;
    try {
      return CheckoutDraftModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      // A corrupt draft is not worth failing checkout over; start a new one.
      return null;
    }
  }

  @override
  Future<void> saveDraft(CheckoutDraftModel draft) async {
    final ok = await _prefs.setString(storageKey, jsonEncode(draft.toJson()));
    if (!ok) throw const CacheException('Could not save checkout draft');
  }
}
