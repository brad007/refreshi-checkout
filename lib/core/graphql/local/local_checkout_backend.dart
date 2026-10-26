import 'dart:async';

import '../../error/exceptions.dart';
import '../../utils/clock.dart';
import 'local_backend_store.dart';
import 'local_graphql_executor.dart';
import 'peach/peach_payments_simulator.dart';
import 'peach/peach_result_code.dart';
import 'seed_data.dart';

/// Timings that make the in-app backend behave like a real one.
class LocalBackendConfig {
  const LocalBackendConfig({
    this.latency = const Duration(milliseconds: 600),
    this.holdConfirmationDelay = const Duration(seconds: 3),
  });

  /// Delay before each response, so loading states and double-clicks are real.
  final Duration latency;

  /// How long Peach Payments (simulated) takes to send the final status.
  final Duration holdConfirmationDelay;
}

/// Resolvers for every root field in `schema.graphql`, plus the business rules
/// a real backend would enforce: validation, idempotent order creation and the
/// asynchronous payment hold through Peach Payments.
class LocalCheckoutBackend {
  LocalCheckoutBackend(
    this._store, {
    required this.clock,
    required this.idGenerator,
    this.config = const LocalBackendConfig(),
    PeachPaymentsSimulator? peach,
  }) : peach =
           peach ??
           PeachPaymentsSimulator(
             clock: clock,
             idGenerator: idGenerator,
             confirmationDelay: config.holdConfirmationDelay,
           ) {
    _webhookSubscription = this.peach.webhooks.listen(_onPeachWebhook);
  }

  final LocalBackendStore _store;
  final Clock clock;
  final String Function() idGenerator;
  final LocalBackendConfig config;

  /// The payment provider. The backend, not the app, talks to Peach: it owns
  /// the merchant credentials and receives the webhooks.
  final PeachPaymentsSimulator peach;

  final _changes = StreamController<String>.broadcast();
  late final StreamSubscription<PeachWebhook> _webhookSubscription;

  late final LocalGraphQLExecutor executor = LocalGraphQLExecutor(
    query: {
      'services': (_) => _respond(() => SeedData.services),
      'paymentMethods': (_) => _respond(() => SeedData.paymentMethods),
      'availableSlots': (args) => _respond(() => availableSlots(args['days'] as int)),
      'order': (args) => _respond(() => _store.order(args['id'] as String)),
    },
    mutation: {'createOrder': (args) => createOrder(args['input'] as Map<String, dynamic>)},
    subscription: {'orderUpdated': (args) => orderUpdated(args['id'] as String)},
  );

  /// Re-arms hold confirmations for orders that were still pending when the
  /// app was last closed or refreshed.
  void resumePendingHolds() {
    for (final order in _store.orders) {
      if (_holdStatus(order) != 'PENDING') continue;
      final hold = order['hold'] as Map<String, dynamic>;
      final payment = PeachPayment(
        id: hold['reference'] as String,
        registrationId: (order['paymentMethod'] as Map)['id'] as String,
        paymentType: hold['paymentType'] as String,
        amount: PeachPaymentsSimulator.formatAmount(hold['amountCents'] as int),
        currency: order['currency'] as String,
        result: PeachResultCode.pending,
        timestamp: '',
      );
      final createdAt = DateTime.parse(order['createdAt'] as String);
      peach.scheduleFinalStatus(payment, dueAt: createdAt.add(config.holdConfirmationDelay));
    }
  }

  List<Map<String, Object>> availableSlots(int days) {
    if (days < 1 || days > 14) {
      throw const LocalGraphQLError.badInput('days must be between 1 and 14');
    }
    final now = clock();
    final earliest = now.add(SeedData.slotLeadTime);
    final today = DateTime(now.year, now.month, now.day);
    return [
      for (var day = 0; day < days; day++)
        for (final hour in SeedData.slotStartHours)
          if (DateTime(today.year, today.month, today.day + day, hour) case final start when start.isAfter(earliest))
            _slot(start),
    ];
  }

  Map<String, Object> _slot(DateTime start) => {
    '__typename': 'TimeSlot',
    'id': 'slot_${start.millisecondsSinceEpoch}',
    'startsAt': start.toUtc().toIso8601String(),
    'endsAt': start.add(SeedData.slotDuration).toUtc().toIso8601String(),
  };

  /// Idempotent: the check-and-insert below runs synchronously before the
  /// first `await`, so even two calls in the same frame (a double click) can't
  /// both create an order. A repeated key with the same payload replays the
  /// original order; with a different payload it is rejected.
  Future<Map<String, Object?>> createOrder(Map<String, dynamic> input) async {
    final key = input['idempotencyKey'] as String;
    final serviceIds = (input['serviceIds'] as List).cast<String>();
    final slotId = input['slotId'] as String;
    final paymentMethodId = input['paymentMethodId'] as String;
    final fingerprint = _fingerprint(serviceIds, slotId, paymentMethodId);

    final existing = _store.idempotencyRecord(key);
    if (existing != null) {
      if (existing.fingerprint != fingerprint) {
        await Future<void>.delayed(config.latency);
        throw LocalGraphQLError(
          'This idempotency key was already used for a different order',
          code: ErrorCodes.idempotencyKeyReused,
          extensions: {'orderId': existing.orderId},
        );
      }
      await Future<void>.delayed(config.latency);
      return _payload(_store.order(existing.orderId)!, replayed: true);
    }

    final order = _buildOrder(serviceIds, slotId, paymentMethodId);
    // Ask Peach for a pre-authorisation on the saved card. It answers
    // "pending" now and sends the final status by webhook later.
    final payment = peach.preauthorize(
      registrationId: paymentMethodId,
      amountCents: order['totalCents'] as int,
      currency: SeedData.currency,
    );
    order['hold'] = {
      '__typename': 'PaymentHold',
      'id': 'hold_${idGenerator()}',
      'status': 'PENDING',
      'amountCents': order['totalCents'],
      'provider': 'PEACH_PAYMENTS',
      'paymentType': payment.paymentType,
      'reference': payment.id,
      'resultCode': payment.result.code,
      'resultDescription': payment.result.description,
    };
    final write = _store.putOrder(
      order,
      idempotency: (key, IdempotencyRecord(orderId: order['id'] as String, fingerprint: fingerprint)),
    );

    // The order is stored *before* the response is delayed: if the tab is
    // refreshed now the client never sees the response, and the retry with
    // the same key has to replay it.
    await write;
    await Future<void>.delayed(config.latency);
    return _payload(order, replayed: false);
  }

  Stream<Map<String, dynamic>> orderUpdated(String id) {
    StreamSubscription<String>? changes;
    late final StreamController<Map<String, dynamic>> controller;
    controller = StreamController(
      onListen: () {
        final order = _store.order(id);
        if (order == null) {
          controller
            ..addError(const LocalGraphQLError.notFound('Order not found'))
            ..close();
          return;
        }
        // Subscribe before emitting the snapshot so no change can slip between.
        changes = _changes.stream.where((changed) => changed == id).listen((_) {
          final updated = _store.order(id)!;
          controller.add(updated);
          if (_isFinal(updated)) {
            changes?.cancel();
            controller.close();
          }
        });
        controller.add(order);
        if (_isFinal(order)) {
          changes?.cancel();
          controller.close();
        }
      },
      onCancel: () => changes?.cancel(),
    );
    return controller.stream;
  }

  void dispose() {
    _webhookSubscription.cancel();
    peach.dispose();
    _changes.close();
  }

  Map<String, Object?> _buildOrder(List<String> serviceIds, String slotId, String paymentMethodId) {
    if (serviceIds.isEmpty) {
      throw const LocalGraphQLError.badInput('Select at least one bag');
    }
    if (serviceIds.length > SeedData.maxServicesPerOrder) {
      throw const LocalGraphQLError.badInput('You can rescue up to ${SeedData.maxServicesPerOrder} bags per order');
    }
    if (serviceIds.toSet().length != serviceIds.length) {
      throw const LocalGraphQLError.badInput('Each bag can only be added once');
    }
    final items = [
      for (final id in serviceIds)
        switch (SeedData.services.where((s) => s['id'] == id).firstOrNull) {
          final service? => {
            '__typename': 'OrderItem',
            'serviceId': id,
            'name': service['name'],
            'priceCents': service['priceCents'],
          },
          null => throw LocalGraphQLError.badInput('Unknown bag "$id"'),
        },
    ];
    final slot = availableSlots(14).where((s) => s['id'] == slotId).firstOrNull;
    if (slot == null) {
      throw const LocalGraphQLError.badInput('That pickup window is no longer available');
    }
    final paymentMethod = SeedData.paymentMethods.where((p) => p['id'] == paymentMethodId).firstOrNull;
    if (paymentMethod == null) {
      throw const LocalGraphQLError.badInput('Unknown payment method');
    }

    final total = items.fold<int>(0, (sum, item) => sum + (item['priceCents'] as int));
    final now = clock().toUtc().toIso8601String();
    return <String, Object?>{
      '__typename': 'Order',
      'id': 'ord_${idGenerator()}',
      'status': 'AWAITING_HOLD',
      'items': items,
      'slot': slot,
      'paymentMethod': paymentMethod,
      'totalCents': total,
      'currency': SeedData.currency,
      'timeline': [_event('ORDER_CREATED', now), _event('HOLD_REQUESTED', now)],
      'createdAt': now,
    };
  }

  /// Handles Peach's PAYMENT webhook. Peach may deliver a final status more
  /// than once and out of order, so only the first final status for a
  /// pending hold is applied.
  void _onPeachWebhook(PeachWebhook webhook) {
    if (webhook.type != 'PAYMENT') return;
    final payment = webhook.payload;
    final order = _store.orders.where((o) => (o['hold'] as Map?)?['reference'] == payment.id).firstOrNull;
    if (order == null || _holdStatus(order) != 'PENDING') return;

    final placed = switch (payment.result.outcome) {
      PeachOutcome.success || PeachOutcome.successNeedsReview => true,
      PeachOutcome.rejected => false,
      PeachOutcome.pending => null,
    };
    if (placed == null) return;

    final now = clock().toUtc().toIso8601String();
    final updated = {
      ...order,
      'status': placed ? 'CONFIRMED' : 'PAYMENT_FAILED',
      'hold': {
        ...(order['hold'] as Map<String, dynamic>),
        'status': placed ? 'PLACED' : 'FAILED',
        'resultCode': payment.result.code,
        'resultDescription': payment.result.description,
      },
      'timeline': [...(order['timeline'] as List), _event(placed ? 'HOLD_PLACED' : 'HOLD_FAILED', now)],
    };
    _store.putOrder(updated);
    if (!_changes.isClosed) _changes.add(order['id'] as String);
  }

  Future<T> _respond<T>(T Function() resolve) async {
    await Future<void>.delayed(config.latency);
    return resolve();
  }

  Map<String, Object?> _payload(Map<String, dynamic> order, {required bool replayed}) => {
    '__typename': 'CreateOrderPayload',
    'order': order,
    'replayed': replayed,
  };

  Map<String, Object> _event(String type, String at) => {'__typename': 'TimelineEvent', 'type': type, 'at': at};

  String _fingerprint(List<String> serviceIds, String slotId, String paymentMethodId) =>
      '${([...serviceIds]..sort()).join(',')}|$slotId|$paymentMethodId';

  String? _holdStatus(Map<String, dynamic> order) => (order['hold'] as Map?)?['status'] as String?;

  bool _isFinal(Map<String, dynamic> order) => _holdStatus(order) != 'PENDING';
}
