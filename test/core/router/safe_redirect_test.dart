import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/core/router/safe_redirect.dart';

void main() {
  test('allows in-app paths', () {
    expect(safeRedirectPath('/orders/ord_1'), '/orders/ord_1');
    expect(safeRedirectPath('/checkout?x=1'), '/checkout?x=1');
  });

  test('falls back for missing, external or looping redirects', () {
    for (final unsafe in [
      null,
      '',
      'https://evil.example',
      '//evil.example/path',
      'javascript:alert(1)',
      'orders/1',
      '/sign-in',
      '/sign-in?redirect=/x',
      'http://[bad',
    ]) {
      expect(safeRedirectPath(unsafe), '/', reason: '$unsafe');
    }
    expect(safeRedirectPath(null, fallback: '/home'), '/home');
  });
}
