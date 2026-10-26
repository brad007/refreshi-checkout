import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/core/error/exceptions.dart';
import 'package:refreshi_checkout/core/graphql/local/local_backend_store.dart';
import 'package:refreshi_checkout/core/graphql/local/local_checkout_backend.dart';
import 'package:refreshi_checkout/core/graphql/local/local_graphql_executor.dart';
import 'package:refreshi_checkout/core/graphql/local/peach/peach_payments_simulator.dart';
import 'package:refreshi_checkout/core/graphql/local/peach/peach_result_code.dart';
import 'package:refreshi_checkout/core/graphql/local/seed_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Thursday 10 Jan 2030, 09:30 local time.
  final start = DateTime(2030, 1, 10, 9, 30);
  const config = LocalBackendConfig(latency: Duration(milliseconds: 100), holdConfirmationDelay: Duration(seconds: 3));

  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  /// Runs [body] in fake time with a backend whose clock follows that time.
  void withBackend(void Function(FakeAsync async, LocalCheckoutBackend backend) body) {
    fakeAsync((async) {
      var ids = 0;
      final backend = LocalCheckoutBackend(
        LocalBackendStore(prefs),
        clock: () => start.add(async.elapsed),
        idGenerator: () => '${++ids}',
        config: config,
      );
      body(async, backend);
      backend.dispose();
    });
  }

  String slotId(DateTime start) => 'slot_${start.millisecondsSinceEpoch}';

  Map<String, dynamic> input({
    String key = 'key-1',
    List<String> serviceIds = const ['bag_bakery'],
    String? slot,
    String paymentMethodId = '8ac7a4a28a5f1e3c018a6b2e0d7f4a01',
  }) => {
    'idempotencyKey': key,
    'serviceIds': serviceIds,
    'slotId': slot ?? slotId(DateTime(2030, 1, 11, 12)),
    'paymentMethodId': paymentMethodId,
  };

  T await_<T>(FakeAsync async, Future<T> future) {
    T? value;
    Object? error;
    future.then<void>((v) => value = v, onError: (Object e) => error = e);
    async.elapse(const Duration(seconds: 1));
    if (error != null) throw error!;
    return value as T;
  }

  group('availableSlots', () {
    test('lists future slots only, respecting the lead time', () {
      withBackend((async, backend) {
        final slots = backend.availableSlots(2);
        // Today 09:30 + 1h lead time: every window from 12:00 is still open.
        expect(slots, hasLength(2 * SeedData.slotStartHours.length));
        expect(slots.first['id'], slotId(DateTime(2030, 1, 10, 12)));
        expect(slots.first['endsAt'], DateTime(2030, 1, 10, 13).toUtc().toIso8601String());
      });
    });

    test('drops windows that start within the lead time', () {
      fakeAsync((async) {
        final backend = LocalCheckoutBackend(
          LocalBackendStore(prefs),
          clock: () => DateTime(2030, 1, 10, 14, 30),
          idGenerator: () => '1',
          config: config,
        );
        // 14:30 + 1h: 12:00 and 15:00 are gone; 17:00 and 19:00 remain.
        expect(backend.availableSlots(1).map((s) => s['id']), [
          slotId(DateTime(2030, 1, 10, 17)),
          slotId(DateTime(2030, 1, 10, 19)),
        ]);
        backend.dispose();
      });
    });

    test('rejects an out-of-range window', () {
      withBackend((async, backend) {
        expect(() => backend.availableSlots(0), throwsA(isA<LocalGraphQLError>()));
        expect(() => backend.availableSlots(15), throwsA(isA<LocalGraphQLError>()));
      });
    });
  });

  group('createOrder', () {
    test('creates an order awaiting its hold', () {
      withBackend((async, backend) {
        final payload = await_(async, backend.createOrder(input(serviceIds: ['bag_bakery', 'bag_grocer'])));
        final order = payload['order'] as Map<String, dynamic>;
        expect(payload['replayed'], isFalse);
        expect(order['status'], 'AWAITING_HOLD');
        expect(order['totalCents'], 6500 + 8900);
        final hold = order['hold'] as Map;
        expect(hold['status'], 'PENDING');
        // A Peach Payments pre-authorisation, pending until the webhook arrives.
        expect(hold['provider'], 'PEACH_PAYMENTS');
        expect(hold['paymentType'], 'PA');
        expect(hold['resultCode'], '000.200.000');
        expect(hold['reference'], isNotEmpty);
        expect((order['timeline'] as List).map((e) => (e as Map)['type']), ['ORDER_CREATED', 'HOLD_REQUESTED']);
      });
    });

    test('a double submit with the same key creates exactly one order', () {
      withBackend((async, backend) {
        // Both calls start in the same frame, like a double click.
        final first = backend.createOrder(input());
        final second = backend.createOrder(input());
        final results = await_(async, Future.wait([first, second]));

        final firstOrder = results[0]['order'] as Map;
        final secondOrder = results[1]['order'] as Map;
        expect(secondOrder['id'], firstOrder['id']);
        expect(results[0]['replayed'], isFalse);
        expect(results[1]['replayed'], isTrue);
        expect(LocalBackendStore(prefs).orders, hasLength(1));
      });
    });

    test('a retry after the original succeeded replays the same order', () {
      withBackend((async, backend) {
        final original = await_(async, backend.createOrder(input()));
        final retry = await_(async, backend.createOrder(input(serviceIds: ['bag_bakery'])));
        expect((retry['order'] as Map)['id'], (original['order'] as Map)['id']);
        expect(retry['replayed'], isTrue);
      });
    });

    test('treats service order as irrelevant to the fingerprint', () {
      withBackend((async, backend) {
        await_(async, backend.createOrder(input(serviceIds: ['bag_grocer', 'bag_cafe'])));
        final retry = await_(async, backend.createOrder(input(serviceIds: ['bag_cafe', 'bag_grocer'])));
        expect(retry['replayed'], isTrue);
      });
    });

    test('rejects a reused key with a different payload and points at the original', () {
      withBackend((async, backend) {
        final original = await_(async, backend.createOrder(input()));
        expect(
          () => await_(async, backend.createOrder(input(serviceIds: ['bag_grocer']))),
          throwsA(
            isA<LocalGraphQLError>()
                .having((e) => e.code, 'code', ErrorCodes.idempotencyKeyReused)
                .having((e) => e.extensions['orderId'], 'orderId', (original['order'] as Map)['id']),
          ),
        );
      });
    });

    test('different keys create different orders', () {
      withBackend((async, backend) {
        final a = await_(async, backend.createOrder(input(key: 'a')));
        final b = await_(async, backend.createOrder(input(key: 'b')));
        expect((a['order'] as Map)['id'], isNot((b['order'] as Map)['id']));
      });
    });

    for (final (description, badInput, message) in [
      ('no bags', {'serviceIds': <String>[]}, 'at least one'),
      (
        'too many bags',
        {
          'serviceIds': ['bag_grocer', 'bag_cafe', 'bag_meals'],
        },
        'up to 2',
      ),
      (
        'duplicate bags',
        {
          'serviceIds': ['bag_grocer', 'bag_grocer'],
        },
        'only be added once',
      ),
      (
        'unknown bag',
        {
          'serviceIds': ['bag_nope'],
        },
        'Unknown bag',
      ),
      ('a past slot', {'slotId': 'slot_0'}, 'no longer available'),
      ('unknown payment method', {'paymentMethodId': 'pm_nope'}, 'payment method'),
    ]) {
      test('rejects $description without recording the key', () {
        withBackend((async, backend) {
          expect(
            () => await_(async, backend.createOrder({...input(), ...badInput})),
            throwsA(
              isA<LocalGraphQLError>()
                  .having((e) => e.code, 'code', ErrorCodes.badUserInput)
                  .having((e) => e.message, 'message', contains(message)),
            ),
          );
          expect(LocalBackendStore(prefs).idempotencyRecord('key-1'), isNull);
        });
      });
    }
  });

  group('payment hold', () {
    test('is placed after the confirmation delay', () {
      withBackend((async, backend) {
        final order = await_(async, backend.createOrder(input()))['order'] as Map;
        final store = LocalBackendStore(prefs);
        expect((store.order(order['id'] as String)!['hold'] as Map)['status'], 'PENDING');

        async.elapse(const Duration(seconds: 3));
        final updated = LocalBackendStore(prefs).order(order['id'] as String)!;
        expect(updated['status'], 'CONFIRMED');
        expect((updated['hold'] as Map)['status'], 'PLACED');
        expect((updated['timeline'] as List).last, containsPair('type', 'HOLD_PLACED'));
        expect((updated['hold'] as Map)['resultCode'], '000.100.110');
      });
    });

    test('fails for the declined test card', () {
      withBackend((async, backend) {
        final order =
            await_(async, backend.createOrder(input(paymentMethodId: SeedData.declinedPaymentMethodId)))['order']
                as Map;
        async.elapse(const Duration(seconds: 3));
        final updated = LocalBackendStore(prefs).order(order['id'] as String)!;
        expect(updated['status'], 'PAYMENT_FAILED');
        expect((updated['timeline'] as List).last, containsPair('type', 'HOLD_FAILED'));
        expect((updated['hold'] as Map)['resultCode'], '800.100.203');
        expect((updated['hold'] as Map)['resultDescription'], 'Insufficient Funds');
      });
    });

    test('pending holds resume after a restart, keeping their original due time', () {
      String? orderId;
      withBackend((async, backend) {
        orderId = (await_(async, backend.createOrder(input()))['order'] as Map)['id'] as String;
        // The "tab" closes 1s after creation: the timer dies with the backend.
      });

      fakeAsync((async) {
        final restarted = LocalCheckoutBackend(
          LocalBackendStore(prefs),
          // 1.1s after creation (latency + the elapse in await_ above).
          clock: () => start.add(const Duration(milliseconds: 1100)).add(async.elapsed),
          idGenerator: () => 'x',
          config: config,
        )..resumePendingHolds();

        async.elapse(const Duration(milliseconds: 1800));
        expect((LocalBackendStore(prefs).order(orderId!)!['hold'] as Map)['status'], 'PENDING');
        async.elapse(const Duration(milliseconds: 200));
        expect((LocalBackendStore(prefs).order(orderId!)!['hold'] as Map)['status'], 'PLACED');
        restarted.dispose();
      });
    });

    test('overdue holds complete immediately on resume', () {
      String? orderId;
      withBackend((async, backend) {
        orderId = (await_(async, backend.createOrder(input()))['order'] as Map)['id'] as String;
      });
      fakeAsync((async) {
        final restarted = LocalCheckoutBackend(
          LocalBackendStore(prefs),
          clock: () => start.add(const Duration(hours: 1)),
          idGenerator: () => 'x',
          config: config,
        )..resumePendingHolds();
        async.flushTimers();
        expect((LocalBackendStore(prefs).order(orderId!)!['hold'] as Map)['status'], 'PLACED');
        restarted.dispose();
      });
    });
  });

  group('Peach webhooks', () {
    test('a duplicate final status is ignored, as Peach may resend', () {
      fakeAsync((async) {
        final peach = _ControllablePeach(start.add(async.elapsed));
        final backend = LocalCheckoutBackend(
          LocalBackendStore(prefs),
          clock: () => start.add(async.elapsed),
          idGenerator: () => 'x',
          config: config,
          peach: peach,
        );
        final order = await_(async, backend.createOrder(input()))['order'] as Map;
        final reference = (order['hold'] as Map)['reference'] as String;

        peach.send(reference, PeachResultCode.testModeSuccess);
        peach.send(reference, PeachResultCode.insufficientFunds);
        async.flushMicrotasks();

        final stored = LocalBackendStore(prefs).order(order['id'] as String)!;
        expect((stored['hold'] as Map)['status'], 'PLACED');
        expect((stored['timeline'] as List).where((e) => (e as Map)['type'] == 'HOLD_PLACED'), hasLength(1));
        backend.dispose();
      });
    });

    test('pending, unknown and non-payment webhooks change nothing', () {
      fakeAsync((async) {
        final peach = _ControllablePeach(start);
        final backend = LocalCheckoutBackend(
          LocalBackendStore(prefs),
          clock: () => start.add(async.elapsed),
          idGenerator: () => 'x',
          config: config,
          peach: peach,
        );
        final order = await_(async, backend.createOrder(input()))['order'] as Map;
        final reference = (order['hold'] as Map)['reference'] as String;

        peach
          ..send(reference, PeachResultCode.pending)
          ..send('unknown-payment', PeachResultCode.testModeSuccess)
          ..send(reference, PeachResultCode.testModeSuccess, type: 'REGISTRATION');
        async.flushMicrotasks();

        expect((LocalBackendStore(prefs).order(order['id'] as String)!['hold'] as Map)['status'], 'PENDING');
        backend.dispose();
      });
    });

    test('a review-flagged success still places the hold', () {
      fakeAsync((async) {
        final peach = _ControllablePeach(start);
        final backend = LocalCheckoutBackend(
          LocalBackendStore(prefs),
          clock: () => start.add(async.elapsed),
          idGenerator: () => 'x',
          config: config,
          peach: peach,
        );
        final order = await_(async, backend.createOrder(input()))['order'] as Map;
        peach.send(
          (order['hold'] as Map)['reference'] as String,
          const PeachResultCode('000.400.000', 'Transaction succeeded (please review manually due to fraud suspicion)'),
        );
        async.flushMicrotasks();
        expect(LocalBackendStore(prefs).order(order['id'] as String)!['status'], 'CONFIRMED');
        backend.dispose();
      });
    });
  });

  group('orderUpdated', () {
    // Real (short) time here: fake_async doesn't deliver the stream's done
    // event, and completion is part of the contract under test.
    const fast = LocalBackendConfig(latency: Duration.zero, holdConfirmationDelay: Duration(milliseconds: 50));
    late LocalCheckoutBackend backend;
    var ids = 0;

    setUp(() {
      backend = LocalCheckoutBackend(
        LocalBackendStore(prefs),
        clock: DateTime.now,
        idGenerator: () => '${++ids}',
        config: fast,
      );
    });

    tearDown(() => backend.dispose());

    Map<String, dynamic> tomorrow({String key = 'key-1', List<String> serviceIds = const ['bag_grocer']}) {
      final now = DateTime.now();
      return input(key: key, serviceIds: serviceIds, slot: slotId(DateTime(now.year, now.month, now.day + 1, 12)));
    }

    Future<String> create({String key = 'key-1', List<String> serviceIds = const ['bag_grocer']}) async =>
        ((await backend.createOrder(tomorrow(key: key, serviceIds: serviceIds)))['order'] as Map)['id'] as String;

    test('emits the snapshot, then the settled order, then completes', () async {
      final orderId = await create();
      final statuses = await backend.orderUpdated(orderId).map((o) => o['status']).toList();
      expect(statuses, ['AWAITING_HOLD', 'CONFIRMED']);
    });

    test('completes straight after the snapshot when the order is already final', () async {
      final orderId = await create();
      await Future<void>.delayed(const Duration(milliseconds: 80));
      final statuses = await backend.orderUpdated(orderId).map((o) => o['status']).toList();
      expect(statuses, ['CONFIRMED']);
    });

    test('errors with NOT_FOUND for an unknown order', () {
      expect(
        backend.orderUpdated('missing'),
        emitsError(isA<LocalGraphQLError>().having((e) => e.code, 'code', ErrorCodes.notFound)),
      );
    });

    test('ignores other orders and stops listening when cancelled', () async {
      final a = await create(key: 'a');
      await create(key: 'b', serviceIds: ['bag_cafe']);
      final events = <String>[];
      final sub = backend.orderUpdated(a).listen((o) => events.add(o['status'] as String));
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();
      await Future<void>.delayed(const Duration(milliseconds: 80));
      expect(events, ['AWAITING_HOLD']);
    });
  });

  test('the executor wires every schema root field', () {
    withBackend((async, backend) {
      expect(backend.executor.query.keys, containsAll(['services', 'paymentMethods', 'availableSlots', 'order']));
      expect(backend.executor.mutation.keys, ['createOrder']);
      expect(backend.executor.subscription.keys, ['orderUpdated']);
      final services = await_(async, Future.value(backend.executor.query['services']!(const {})));
      expect(services, SeedData.services);
      final methods = await_(async, Future.value(backend.executor.query['paymentMethods']!(const {})));
      expect(methods, SeedData.paymentMethods);
      final missing = await_(async, Future.value(backend.executor.query['order']!(const {'id': 'nope'})));
      expect(missing, isNull);
      final slots = await_(async, Future.value(backend.executor.query['availableSlots']!(const {'days': 1})));
      expect(slots, isNotEmpty);
    });
  });

  test('dispose cancels pending holds', () {
    fakeAsync((async) {
      final backend = LocalCheckoutBackend(
        LocalBackendStore(prefs),
        clock: () => start.add(async.elapsed),
        idGenerator: () => '1',
        config: config,
      );
      unawaited(backend.createOrder(input()));
      async.elapse(const Duration(milliseconds: 500));
      backend.dispose();
      async.elapse(const Duration(seconds: 10));
      expect((LocalBackendStore(prefs).orders.single['hold'] as Map)['status'], 'PENDING');
    });
  });
}

/// A Peach stand-in whose webhooks the test sends by hand.
class _ControllablePeach extends PeachPaymentsSimulator {
  _ControllablePeach(DateTime now) : super(clock: () => now, idGenerator: () => 'peach-1');

  final _manual = StreamController<PeachWebhook>.broadcast();

  @override
  Stream<PeachWebhook> get webhooks => _manual.stream;

  @override
  void scheduleFinalStatus(PeachPayment payment, {required DateTime dueAt}) {}

  void send(String paymentId, PeachResultCode result, {String type = 'PAYMENT'}) => _manual.add(
    PeachWebhook(
      type: type,
      payload: PeachPayment(
        id: paymentId,
        registrationId: 'r',
        paymentType: 'PA',
        amount: '1.00',
        currency: 'ZAR',
        result: result,
        timestamp: '',
      ),
    ),
  );
}
