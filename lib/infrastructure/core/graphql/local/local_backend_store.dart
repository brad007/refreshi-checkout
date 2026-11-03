import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// What the backend remembers about an idempotency key: which order it created
/// and a fingerprint of the request, so a reused key with a different payload
/// can be rejected instead of silently returning the wrong order.
class IdempotencyRecord {
  const IdempotencyRecord({required this.orderId, required this.fingerprint});

  factory IdempotencyRecord.fromJson(Map<String, dynamic> json) =>
      IdempotencyRecord(orderId: json['orderId'] as String, fingerprint: json['fingerprint'] as String);

  final String orderId;
  final String fingerprint;

  Map<String, dynamic> toJson() => {'orderId': orderId, 'fingerprint': fingerprint};
}

/// The in-app backend's "database". Kept in memory for synchronous reads and
/// written through to shared_preferences (localStorage on web), so orders
/// survive a browser refresh exactly like they would on a real server.
class LocalBackendStore {
  LocalBackendStore(this._prefs) {
    _load();
  }

  static const storageKey = 'local_backend.v2';

  final SharedPreferences _prefs;
  final Map<String, Map<String, dynamic>> _orders = {};
  final Map<String, IdempotencyRecord> _idempotency = {};

  Iterable<Map<String, dynamic>> get orders => _orders.values;

  Map<String, dynamic>? order(String id) => _orders[id];

  IdempotencyRecord? idempotencyRecord(String key) => _idempotency[key];

  /// Updates memory synchronously (so concurrent requests see it at once) and
  /// returns a future that completes when the write is durable.
  Future<void> putOrder(Map<String, dynamic> order, {(String, IdempotencyRecord)? idempotency}) {
    _orders[order['id'] as String] = order;
    if (idempotency != null) _idempotency[idempotency.$1] = idempotency.$2;
    return _flush();
  }

  void _load() {
    final raw = _prefs.getString(storageKey);
    if (raw == null) return;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final orders = (json['orders'] as Map<String, dynamic>? ?? {});
      final keys = (json['idempotency'] as Map<String, dynamic>? ?? {});
      _orders.addAll(orders.map((k, v) => MapEntry(k, v as Map<String, dynamic>)));
      _idempotency.addAll(keys.map((k, v) => MapEntry(k, IdempotencyRecord.fromJson(v as Map<String, dynamic>))));
    } on Object {
      // Corrupt data from an older build: start fresh rather than crash.
      _orders.clear();
      _idempotency.clear();
    }
  }

  Future<void> _flush() => _prefs.setString(
    storageKey,
    jsonEncode({'orders': _orders, 'idempotency': _idempotency.map((k, v) => MapEntry(k, v.toJson()))}),
  );
}
