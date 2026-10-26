// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_draft_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CheckoutDraftModel _$CheckoutDraftModelFromJson(Map<String, dynamic> json) => _CheckoutDraftModel(
  idempotencyKey: json['idempotencyKey'] as String,
  serviceIds: (json['serviceIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
  slotId: json['slotId'] as String?,
  paymentMethodId: json['paymentMethodId'] as String?,
  submissionInFlight: json['submissionInFlight'] as bool? ?? false,
);

Map<String, dynamic> _$CheckoutDraftModelToJson(_CheckoutDraftModel instance) => <String, dynamic>{
  'idempotencyKey': instance.idempotencyKey,
  'serviceIds': instance.serviceIds,
  'slotId': instance.slotId,
  'paymentMethodId': instance.paymentMethodId,
  'submissionInFlight': instance.submissionInFlight,
};
