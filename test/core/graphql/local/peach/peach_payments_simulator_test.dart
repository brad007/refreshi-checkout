import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/core/graphql/local/peach/peach_payments_simulator.dart';
import 'package:refreshi_checkout/core/graphql/local/peach/peach_result_code.dart';

void main() {
  final start = DateTime.utc(2030, 1, 10, 9, 5, 7);
  const visa = '8ac7a4a28a5f1e3c018a6b2e0d7f4a01';

  PeachPaymentsSimulator build(FakeAsync async) => PeachPaymentsSimulator(
    clock: () => start.add(async.elapsed),
    idGenerator: () => '8ac7a4a289d210fc0189d5b4e9572cc8',
  );

  test('a pre-authorisation is pending, then confirmed by a PAYMENT webhook', () {
    fakeAsync((async) {
      final peach = build(async);
      final webhooks = <PeachWebhook>[];
      peach.webhooks.listen(webhooks.add);

      final payment = peach.preauthorize(registrationId: visa, amountCents: 15400, currency: 'ZAR');

      expect(payment.paymentType, 'PA');
      expect(payment.amount, '154.00');
      expect(payment.currency, 'ZAR');
      expect(payment.registrationId, visa);
      expect(payment.result.code, '000.200.000');
      expect(payment.timestamp, '2030-01-10 09:05:07+0000');

      async.elapse(const Duration(milliseconds: 2900));
      expect(webhooks, isEmpty);
      async.elapse(const Duration(milliseconds: 200));

      final webhook = webhooks.single;
      expect(webhook.type, 'PAYMENT');
      expect(webhook.payload.id, payment.id);
      expect(webhook.payload.result.code, '000.100.110');
      expect(webhook.payload.result.outcome, PeachOutcome.success);
      expect(webhook.payload.timestamp, '2030-01-10 09:05:10+0000');
      peach.dispose();
    });
  });

  test('the decline token gets Insufficient Funds', () {
    fakeAsync((async) {
      final peach = build(async);
      PeachWebhook? webhook;
      peach.webhooks.listen((w) => webhook = w);
      peach.preauthorize(
        registrationId: PeachPaymentsSimulator.declinedRegistrations.single,
        amountCents: 100,
        currency: 'ZAR',
      );
      async.elapse(const Duration(seconds: 3));
      expect(webhook!.payload.result, PeachResultCode.insufficientFunds);
      peach.dispose();
    });
  });

  test('scheduling the same payment twice sends one webhook', () {
    fakeAsync((async) {
      final peach = build(async);
      final webhooks = <PeachWebhook>[];
      peach.webhooks.listen(webhooks.add);
      final payment = peach.preauthorize(registrationId: visa, amountCents: 100, currency: 'ZAR');
      peach.scheduleFinalStatus(payment, dueAt: start);
      async.elapse(const Duration(seconds: 5));
      expect(webhooks, hasLength(1));
      peach.dispose();
    });
  });

  test('an overdue payment is finalised straight away', () {
    fakeAsync((async) {
      final peach = build(async);
      final webhooks = <PeachWebhook>[];
      peach.webhooks.listen(webhooks.add);
      final payment = const PeachPayment(
        id: 'p1',
        registrationId: visa,
        paymentType: 'PA',
        amount: '1.00',
        currency: 'ZAR',
        result: PeachResultCode.pending,
        timestamp: '',
      );
      peach.scheduleFinalStatus(payment, dueAt: start.subtract(const Duration(minutes: 5)));
      async.flushTimers();
      expect(webhooks.single.payload.id, 'p1');
      peach.dispose();
    });
  });

  test('dispose cancels outstanding webhooks', () {
    fakeAsync((async) {
      final peach = build(async);
      peach.preauthorize(registrationId: visa, amountCents: 100, currency: 'ZAR');
      peach.dispose();
      async.elapse(const Duration(seconds: 5));
      expect(async.pendingTimers, isEmpty);
    });
  });

  test('formats amounts the way Peach expects', () {
    expect(PeachPaymentsSimulator.formatAmount(15400), '154.00');
    expect(PeachPaymentsSimulator.formatAmount(5), '0.05');
    expect(PeachPaymentsSimulator.formatAmount(1999), '19.99');
  });
}
