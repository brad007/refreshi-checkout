/// Peach Payments result codes (`ddd.ddd.ddd`) and the groupings Peach
/// documents for interpreting them. The patterns are Peach's published
/// regexes, with the dots escaped.
///
/// https://developer.peachpayments.com/docs/dashboard-response-codes
enum PeachOutcome { success, successNeedsReview, pending, rejected }

class PeachResultCode {
  const PeachResultCode(this.code, this.description);

  // Codes this simulator returns. All are real Peach codes.
  static const testModeSuccess = PeachResultCode(
    '000.100.110',
    "Request successfully processed in 'Merchant in Integrator Test Mode'",
  );
  static const pending = PeachResultCode('000.200.000', 'transaction pending');
  static const insufficientFunds = PeachResultCode('800.100.203', 'Insufficient Funds');

  static final _success = RegExp(r'^(000\.000\.|000\.100\.1|000\.[36]|000\.400\.[1][12]0)');
  static final _review = RegExp(r'^(000\.400\.0[^3]|000\.400\.100)');
  static final _pending = RegExp(r'^(000\.200|800\.400\.5|100\.400\.500)');

  final String code;
  final String description;

  /// Anything not successful, under review or pending is treated as rejected
  /// (bank declines, risk rejections, communication and system errors).
  PeachOutcome get outcome {
    if (_success.hasMatch(code)) return PeachOutcome.success;
    if (_review.hasMatch(code)) return PeachOutcome.successNeedsReview;
    if (_pending.hasMatch(code)) return PeachOutcome.pending;
    return PeachOutcome.rejected;
  }

  Map<String, String> toJson() => {'code': code, 'description': description};
}
