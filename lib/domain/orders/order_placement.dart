import 'package:freezed_annotation/freezed_annotation.dart';

import 'order.dart';

part 'order_placement.freezed.dart';

/// Result of placing an order. [replayed] is true when the request was a retry
/// of one that had already succeeded, and the original order was returned.
@freezed
abstract class OrderPlacement with _$OrderPlacement {
  const factory OrderPlacement({required CustomerOrder order, required bool replayed}) = _OrderPlacement;
}
