import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/core/utils/date_formatter.dart';
import 'package:refreshi_checkout/core/utils/money_formatter.dart';

void main() {
  test('formats cents as rand', () {
    expect(formatMoney(130000), 'R1 300,00');
    expect(formatMoney(5), 'R0,05');
  });

  test('prefixes other currencies with their code', () {
    expect(formatMoney(1000, currency: 'USD'), startsWith('USD'));
  });

  test('formats slot days, times and timestamps', () {
    final start = DateTime(2030, 1, 3, 8);
    expect(formatSlotDay(start), 'Thu 3 Jan');
    expect(formatSlotTime(start, DateTime(2030, 1, 3, 10)), '08:00 – 10:00');
    expect(formatTimestamp(DateTime(2030, 1, 3, 8, 5, 9)), '3 Jan, 08:05:09');
  });
}
