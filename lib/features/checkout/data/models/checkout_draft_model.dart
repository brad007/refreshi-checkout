import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/checkout_draft.dart';

part 'checkout_draft_model.freezed.dart';
part 'checkout_draft_model.g.dart';

@freezed
abstract class CheckoutDraftModel with _$CheckoutDraftModel {
  const CheckoutDraftModel._();

  const factory CheckoutDraftModel({
    required String idempotencyKey,
    @Default([]) List<String> serviceIds,
    String? slotId,
    String? paymentMethodId,
    @Default(false) bool submissionInFlight,
  }) = _CheckoutDraftModel;

  factory CheckoutDraftModel.fromJson(Map<String, dynamic> json) => _$CheckoutDraftModelFromJson(json);

  factory CheckoutDraftModel.fromEntity(CheckoutDraft draft) => CheckoutDraftModel(
    idempotencyKey: draft.idempotencyKey,
    serviceIds: draft.serviceIds,
    slotId: draft.slotId,
    paymentMethodId: draft.paymentMethodId,
    submissionInFlight: draft.submissionInFlight,
  );

  CheckoutDraft toEntity() => CheckoutDraft(
    idempotencyKey: idempotencyKey,
    serviceIds: serviceIds,
    slotId: slotId,
    paymentMethodId: paymentMethodId,
    submissionInFlight: submissionInFlight,
  );
}
