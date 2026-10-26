import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method.freezed.dart';

/// A saved card, referenced only by its token. No card data lives in the app.
@freezed
abstract class PaymentMethod with _$PaymentMethod {
  const PaymentMethod._();

  const factory PaymentMethod({required String id, required String brand, required String last4}) = _PaymentMethod;

  String get label => '$brand •••• $last4';
}
