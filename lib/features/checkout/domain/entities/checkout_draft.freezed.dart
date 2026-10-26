// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutDraft {

 String get idempotencyKey; List<String> get serviceIds; String? get slotId; String? get paymentMethodId;/// Set just before the order request is sent and cleared when it settles.
/// If the page reloads while this is true the outcome is unknown, so the
/// checkout resubmits with the same key, which is safe.
 bool get submissionInFlight;
/// Create a copy of CheckoutDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutDraftCopyWith<CheckoutDraft> get copyWith => _$CheckoutDraftCopyWithImpl<CheckoutDraft>(this as CheckoutDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CheckoutDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutDraft&&(identical(other.idempotencyKey, _this.idempotencyKey) || other.idempotencyKey == _this.idempotencyKey)&&const DeepCollectionEquality().equals(other.serviceIds, _this.serviceIds)&&(identical(other.slotId, _this.slotId) || other.slotId == _this.slotId)&&(identical(other.paymentMethodId, _this.paymentMethodId) || other.paymentMethodId == _this.paymentMethodId)&&(identical(other.submissionInFlight, _this.submissionInFlight) || other.submissionInFlight == _this.submissionInFlight));
}


@override
int get hashCode {
  final _this = this as CheckoutDraft;
  return Object.hash(runtimeType,_this.idempotencyKey,const DeepCollectionEquality().hash(_this.serviceIds),_this.slotId,_this.paymentMethodId,_this.submissionInFlight);
}

@override
String toString() {
  final _this = this as CheckoutDraft;
  return 'CheckoutDraft(idempotencyKey: ${_this.idempotencyKey}, serviceIds: ${_this.serviceIds}, slotId: ${_this.slotId}, paymentMethodId: ${_this.paymentMethodId}, submissionInFlight: ${_this.submissionInFlight})';
}


}

/// @nodoc
abstract mixin class $CheckoutDraftCopyWith<$Res>  {
  factory $CheckoutDraftCopyWith(CheckoutDraft value, $Res Function(CheckoutDraft) _then) = _$CheckoutDraftCopyWithImpl;
@useResult
$Res call({
 String idempotencyKey, List<String> serviceIds, String? slotId, String? paymentMethodId, bool submissionInFlight
});




}
/// @nodoc
class _$CheckoutDraftCopyWithImpl<$Res>
    implements $CheckoutDraftCopyWith<$Res> {
  _$CheckoutDraftCopyWithImpl(this._self, this._then);

  final CheckoutDraft _self;
  final $Res Function(CheckoutDraft) _then;

/// Create a copy of CheckoutDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idempotencyKey = null,Object? serviceIds = null,Object? slotId = freezed,Object? paymentMethodId = freezed,Object? submissionInFlight = null,}) {
  return _then(CheckoutDraft(
idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,serviceIds: null == serviceIds ? _self.serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<String>,slotId: freezed == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String?,paymentMethodId: freezed == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as String?,submissionInFlight: null == submissionInFlight ? _self.submissionInFlight : submissionInFlight // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutDraft].
extension CheckoutDraftPatterns on CheckoutDraft {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutDraft() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutDraft value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutDraft():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutDraft value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutDraft() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String idempotencyKey,  List<String> serviceIds,  String? slotId,  String? paymentMethodId,  bool submissionInFlight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutDraft() when $default != null:
return $default(_that.idempotencyKey,_that.serviceIds,_that.slotId,_that.paymentMethodId,_that.submissionInFlight);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String idempotencyKey,  List<String> serviceIds,  String? slotId,  String? paymentMethodId,  bool submissionInFlight)  $default,) {final _that = this;
switch (_that) {
case _CheckoutDraft():
return $default(_that.idempotencyKey,_that.serviceIds,_that.slotId,_that.paymentMethodId,_that.submissionInFlight);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String idempotencyKey,  List<String> serviceIds,  String? slotId,  String? paymentMethodId,  bool submissionInFlight)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutDraft() when $default != null:
return $default(_that.idempotencyKey,_that.serviceIds,_that.slotId,_that.paymentMethodId,_that.submissionInFlight);case _:
  return null;

}
}

}

/// @nodoc


class _CheckoutDraft extends CheckoutDraft {
  const _CheckoutDraft({required this.idempotencyKey,  List<String> serviceIds = const [], this.slotId, this.paymentMethodId, this.submissionInFlight = false}): _serviceIds = serviceIds,super._();
  

@override final  String idempotencyKey;
 final  List<String> _serviceIds;
@override@JsonKey() List<String> get serviceIds {
  if (_serviceIds is EqualUnmodifiableListView) return _serviceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceIds);
}

@override final  String? slotId;
@override final  String? paymentMethodId;
/// Set just before the order request is sent and cleared when it settles.
/// If the page reloads while this is true the outcome is unknown, so the
/// checkout resubmits with the same key, which is safe.
@override@JsonKey() final  bool submissionInFlight;

/// Create a copy of CheckoutDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutDraftCopyWith<_CheckoutDraft> get copyWith => __$CheckoutDraftCopyWithImpl<_CheckoutDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutDraft&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey)&&const DeepCollectionEquality().equals(other.serviceIds, _serviceIds)&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.paymentMethodId, paymentMethodId) || other.paymentMethodId == paymentMethodId)&&(identical(other.submissionInFlight, submissionInFlight) || other.submissionInFlight == submissionInFlight));
}


@override
int get hashCode {
    return Object.hash(runtimeType,idempotencyKey,const DeepCollectionEquality().hash(_serviceIds),slotId,paymentMethodId,submissionInFlight);
}

@override
String toString() {
    return 'CheckoutDraft(idempotencyKey: $idempotencyKey, serviceIds: $serviceIds, slotId: $slotId, paymentMethodId: $paymentMethodId, submissionInFlight: $submissionInFlight)';
}


}

/// @nodoc
abstract mixin class _$CheckoutDraftCopyWith<$Res> implements $CheckoutDraftCopyWith<$Res> {
  factory _$CheckoutDraftCopyWith(_CheckoutDraft value, $Res Function(_CheckoutDraft) _then) = __$CheckoutDraftCopyWithImpl;
@override @useResult
$Res call({
 String idempotencyKey, List<String> serviceIds, String? slotId, String? paymentMethodId, bool submissionInFlight
});




}
/// @nodoc
class __$CheckoutDraftCopyWithImpl<$Res>
    implements _$CheckoutDraftCopyWith<$Res> {
  __$CheckoutDraftCopyWithImpl(this._self, this._then);

  final _CheckoutDraft _self;
  final $Res Function(_CheckoutDraft) _then;

/// Create a copy of CheckoutDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idempotencyKey = null,Object? serviceIds = null,Object? slotId = freezed,Object? paymentMethodId = freezed,Object? submissionInFlight = null,}) {
  return _then(_CheckoutDraft(
idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,serviceIds: null == serviceIds ? _self._serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<String>,slotId: freezed == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String?,paymentMethodId: freezed == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as String?,submissionInFlight: null == submissionInFlight ? _self.submissionInFlight : submissionInFlight // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
