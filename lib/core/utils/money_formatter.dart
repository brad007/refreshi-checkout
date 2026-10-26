import 'package:intl/intl.dart';

/// Formats integer minor units (cents) for display. Money is never a double.
String formatMoney(int cents, {String currency = 'ZAR'}) {
  final format = NumberFormat.currency(
    locale: 'en_ZA',
    name: currency,
    symbol: currency == 'ZAR' ? 'R' : '$currency ',
    decimalDigits: 2,
  );
  return format.format(cents / 100);
}
