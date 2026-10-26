import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../catalog/domain/entities/payment_method.dart';
import '../../../catalog/domain/entities/time_slot.dart';

part 'order.freezed.dart';

enum OrderStatus { awaitingHold, confirmed, paymentFailed }

enum HoldStatus { pending, placed, failed }

enum TimelineEventType { orderCreated, holdRequested, holdPlaced, holdFailed }

@freezed
abstract class CustomerOrder with _$CustomerOrder {
  const CustomerOrder._();

  const factory CustomerOrder({
    required String id,
    required OrderStatus status,
    required List<OrderItem> items,
    required TimeSlot slot,
    required PaymentMethod paymentMethod,
    required int totalCents,
    required String currency,
    required PaymentHold hold,
    required List<TimelineEvent> timeline,
    required DateTime createdAt,
  }) = _CustomerOrder;

  /// True while we're still waiting for the payment provider.
  bool get isPending => hold.status == HoldStatus.pending;
}

@freezed
abstract class OrderItem with _$OrderItem {
  const factory OrderItem({required String serviceId, required String name, required int priceCents}) = _OrderItem;
}

@freezed
abstract class PaymentHold with _$PaymentHold {
  const factory PaymentHold({
    required String id,
    required HoldStatus status,
    required int amountCents,

    /// The provider that holds the funds: Peach Payments.
    @Default('PEACH_PAYMENTS') String provider,

    /// Peach `paymentType`; `PA` is a pre-authorisation.
    @Default('PA') String paymentType,

    /// Peach's payment id, for support and reconciliation.
    @Default('') String reference,

    /// Peach result code and description, e.g. `000.100.110`.
    @Default('') String resultCode,
    @Default('') String resultDescription,
  }) = _PaymentHold;
}

@freezed
abstract class TimelineEvent with _$TimelineEvent {
  const factory TimelineEvent({required TimelineEventType type, required DateTime at}) = _TimelineEvent;
}
