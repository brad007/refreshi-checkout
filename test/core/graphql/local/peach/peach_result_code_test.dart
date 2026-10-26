import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/core/graphql/local/peach/peach_result_code.dart';

PeachOutcome _outcome(String code) => PeachResultCode(code, '').outcome;

void main() {
  test('classifies successful codes', () {
    for (final code in ['000.000.000', '000.100.110', '000.100.112', '000.300.000', '000.600.000', '000.400.110']) {
      expect(_outcome(code), PeachOutcome.success, reason: code);
    }
  });

  test('classifies codes that succeed but need review', () {
    for (final code in ['000.400.000', '000.400.100']) {
      expect(_outcome(code), PeachOutcome.successNeedsReview, reason: code);
    }
  });

  test('classifies pending codes', () {
    for (final code in ['000.200.000', '000.200.100', '800.400.500', '100.400.500']) {
      expect(_outcome(code), PeachOutcome.pending, reason: code);
    }
  });

  test('treats declines, risk, communication and system errors as rejected', () {
    for (final code in [
      '800.100.203',
      '800.100.151',
      '800.100.183',
      '000.400.030',
      '900.100.300',
      '999.999.999',
      '100.396.101',
    ]) {
      expect(_outcome(code), PeachOutcome.rejected, reason: code);
    }
  });

  test('the simulator\'s own codes are real Peach codes in the right groups', () {
    expect(PeachResultCode.testModeSuccess.outcome, PeachOutcome.success);
    expect(PeachResultCode.pending.outcome, PeachOutcome.pending);
    expect(PeachResultCode.insufficientFunds.outcome, PeachOutcome.rejected);
    expect(PeachResultCode.insufficientFunds.toJson(), {'code': '800.100.203', 'description': 'Insufficient Funds'});
  });
}
