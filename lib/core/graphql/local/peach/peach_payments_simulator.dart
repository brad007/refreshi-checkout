import 'dart:async';

import '../../../utils/clock.dart';
import 'peach_result_code.dart';

/// A payment as Peach Payments returns it (subset of the documented JSON).
class PeachPayment {
  const PeachPayment({
    required this.id,
    required this.registrationId,
    required this.paymentType,
    required this.amount,
    required this.currency,
    required this.result,
    required this.timestamp,
  });

  final String id;
  final String registrationId;

  /// `PA` = pre-authorisation (a hold), `CP` = capture, `RV` = reversal.
  final String paymentType;

  /// Peach sends amounts as strings with two decimals, e.g. `"130.00"`.
  final String amount;
  final String currency;
  final PeachResultCode result;

  /// Peach's format: `2026-10-23 15:12:30+0000`.
  final String timestamp;

  PeachPayment withResult(PeachResultCode result, String timestamp) => PeachPayment(
    id: id,
    registrationId: registrationId,
    paymentType: paymentType,
    amount: amount,
    currency: currency,
    result: result,
    timestamp: timestamp,
  );
}

/// A decrypted Peach webhook: `{"type": "PAYMENT", "payload": {...}}`.
class PeachWebhook {
  const PeachWebhook({required this.type, required this.payload});

  final String type;
  final PeachPayment payload;
}

/// Stands in for Peach Payments' server-to-server API in the in-app backend.
///
/// It mirrors the documented flow for charging a stored card:
/// `POST /v1/registrations/{registrationId}/payments` with `paymentType=PA`
/// returns a pending result straight away, and the final status arrives
/// later as a `PAYMENT` webhook. In production this class would be an HTTP
/// client for `https://sandbox-card.peachpayments.com` (Bearer auth,
/// form-encoded body) plus a webhook endpoint that decrypts AES-256-GCM
/// payloads. That has to live on a server, never in the app, because it
/// holds the merchant's secret.
class PeachPaymentsSimulator {
  PeachPaymentsSimulator({
    required this.clock,
    required this.idGenerator,
    this.confirmationDelay = const Duration(seconds: 3),
  });

  /// Registration tokens that simulate a bank decline. Peach doesn't publish
  /// decline test cards, so the simulator assigns one.
  static const declinedRegistrations = {'8ac7a4a28a5f1e3c018a6b2e0d7f4c19'};

  final Clock clock;
  final String Function() idGenerator;
  final Duration confirmationDelay;

  final _webhooks = StreamController<PeachWebhook>.broadcast();
  final _timers = <String, Timer>{};

  /// Webhooks Peach would POST to the merchant's notification URL.
  Stream<PeachWebhook> get webhooks => _webhooks.stream;

  /// `POST /v1/registrations/{registrationId}/payments` with `paymentType=PA`.
  PeachPayment preauthorize({required String registrationId, required int amountCents, required String currency}) {
    final payment = PeachPayment(
      id: idGenerator(),
      registrationId: registrationId,
      paymentType: 'PA',
      amount: formatAmount(amountCents),
      currency: currency,
      result: PeachResultCode.pending,
      timestamp: formatTimestamp(clock()),
    );
    scheduleFinalStatus(payment, dueAt: clock().add(confirmationDelay));
    return payment;
  }

  /// Arms the webhook for a pending payment. Also used to resume after a
  /// restart, keeping the original due time.
  void scheduleFinalStatus(PeachPayment payment, {required DateTime dueAt}) {
    if (_timers.containsKey(payment.id)) return;
    final remaining = dueAt.difference(clock());
    _timers[payment.id] = Timer(remaining.isNegative ? Duration.zero : remaining, () {
      _timers.remove(payment.id);
      final result = declinedRegistrations.contains(payment.registrationId)
          ? PeachResultCode.insufficientFunds
          : PeachResultCode.testModeSuccess;
      if (!_webhooks.isClosed) {
        _webhooks.add(PeachWebhook(type: 'PAYMENT', payload: payment.withResult(result, formatTimestamp(clock()))));
      }
    });
  }

  void dispose() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
    _webhooks.close();
  }

  static String formatAmount(int cents) => '${cents ~/ 100}.${(cents % 100).toString().padLeft(2, '0')}';

  static String formatTimestamp(DateTime at) {
    final u = at.toUtc();
    String two(int v) => v.toString().padLeft(2, '0');
    return '${u.year}-${two(u.month)}-${two(u.day)} ${two(u.hour)}:${two(u.minute)}:${two(u.second)}+0000';
  }
}
