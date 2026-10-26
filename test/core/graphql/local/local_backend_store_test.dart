import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/core/graphql/local/local_backend_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('persists orders and idempotency records across instances', () async {
    final prefs = await SharedPreferences.getInstance();
    final store = LocalBackendStore(prefs);
    await store.putOrder(
      {'id': 'ord_1', 'status': 'AWAITING_HOLD'},
      idempotency: ('key-1', const IdempotencyRecord(orderId: 'ord_1', fingerprint: 'fp')),
    );

    final reloaded = LocalBackendStore(prefs);
    expect(reloaded.order('ord_1'), {'id': 'ord_1', 'status': 'AWAITING_HOLD'});
    expect(reloaded.orders, hasLength(1));
    final record = reloaded.idempotencyRecord('key-1')!;
    expect(record.orderId, 'ord_1');
    expect(record.fingerprint, 'fp');
  });

  test('updates memory synchronously, before the write completes', () async {
    final store = LocalBackendStore(await SharedPreferences.getInstance());
    final write = store.putOrder({'id': 'ord_1'});
    expect(store.order('ord_1'), isNotNull);
    await write;
  });

  test('starts empty when storage is empty', () async {
    final store = LocalBackendStore(await SharedPreferences.getInstance());
    expect(store.orders, isEmpty);
    expect(store.idempotencyRecord('x'), isNull);
  });

  test('starts empty instead of crashing on corrupt data', () async {
    SharedPreferences.setMockInitialValues({LocalBackendStore.storageKey: '{not json'});
    final store = LocalBackendStore(await SharedPreferences.getInstance());
    expect(store.orders, isEmpty);
  });

  test('tolerates missing sections', () async {
    SharedPreferences.setMockInitialValues({LocalBackendStore.storageKey: '{}'});
    final store = LocalBackendStore(await SharedPreferences.getInstance());
    expect(store.orders, isEmpty);
  });
}
