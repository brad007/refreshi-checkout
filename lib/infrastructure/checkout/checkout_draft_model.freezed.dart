// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_draft_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckoutDraftModel {

 String get idempotencyKey; List<String> get serviceIds; String? get slotId; String? get paymentMethodId; bool get submissionInFlight;
/// Create a copy of CheckoutDraftModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutDraftModelCopyWith<CheckoutDraftModel> get copyWith => _$CheckoutDraftModelCopyWithImpl<CheckoutDraftModel>(this as CheckoutDraftModel, _$identity);

  /// Serializes this CheckoutDraftModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CheckoutDraftModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutDraftModel&&(identical(other.idempotencyKey, _this.idempotencyKey) || other.idempotencyKey == _this.idempotencyKey)&&const DeepCollectionEquality().equals(other.serviceIds, _this.serviceIds)&&(identical(other.slotId, _this.slotId) || other.slotId == _this.slotId)&&(identical(other.paymentMethodId, _this.paymentMethodId) || other.paymentMethodId == _this.paymentMethodId)&&(identical(other.submissionInFlight, _this.submissionInFlight) || other.submissionInFlight == _this.submissionInFlight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CheckoutDraftModel;
  return Object.hash(runtimeType,_this.idempotencyKey,const DeepCollectionEquality().hash(_this.serviceIds),_this.slotId,_this.paymentMethodId,_this.submissionInFlight);
}

@override
String toString() {
  final _this = this as CheckoutDraftModel;
  return 'CheckoutDraftModel(idempotencyKey: ${_this.idempotencyKey}, serviceIds: ${_this.serviceIds}, slotId: ${_this.slotId}, paymentMethodId: ${_this.paymentMethodId}, submissionInFlight: ${_this.submissionInFlight})';
}


}

/// @nodoc
abstract mixin class $CheckoutDraftModelCopyWith<$Res>  {
  factory $CheckoutDraftModelCopyWith(CheckoutDraftModel value, $Res Function(CheckoutDraftModel) _then) = _$CheckoutDraftModelCopyWithImpl;
@useResult
$Res call({
 String idempotencyKey, List<String> serviceIds, String? slotId, String? paymentMethodId, bool submissionInFlight
});




}
/// @nodoc
class _$CheckoutDraftModelCopyWithImpl<$Res>
    implements $CheckoutDraftModelCopyWith<$Res> {
  _$CheckoutDraftModelCopyWithImpl(this._self, this._then);

  final CheckoutDraftModel _self;
  final $Res Function(CheckoutDraftModel) _then;

/// Create a copy of CheckoutDraftModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idempotencyKey = null,Object? serviceIds = null,Object? slotId = freezed,Object? paymentMethodId = freezed,Object? submissionInFlight = null,}) {
  return _then(CheckoutDraftModel(
idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,serviceIds: null == serviceIds ? _self.serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<String>,slotId: freezed == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String?,paymentMethodId: freezed == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as String?,submissionInFlight: null == submissionInFlight ? _self.submissionInFlight : submissionInFlight // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutDraftModel].
extension CheckoutDraftModelPatterns on CheckoutDraftModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutDraftModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutDraftModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutDraftModel value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutDraftModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutDraftModel value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutDraftModel() when $default != null:
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
case _CheckoutDraftModel() when $default != null:
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
case _CheckoutDraftModel():
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
case _CheckoutDraftModel() when $default != null:
return $default(_that.idempotencyKey,_that.serviceIds,_that.slotId,_that.paymentMethodId,_that.submissionInFlight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckoutDraftModel extends CheckoutDraftModel {
  const _CheckoutDraftModel({required this.idempotencyKey,  List<String> serviceIds = const [], this.slotId, this.paymentMethodId, this.submissionInFlight = false}): _serviceIds = serviceIds,super._();
  factory _CheckoutDraftModel.fromJson(Map<String, dynamic> json) => _$CheckoutDraftModelFromJson(json);

@override final  String idempotencyKey;
 final  List<String> _serviceIds;
@override@JsonKey() List<String> get serviceIds {
  if (_serviceIds is EqualUnmodifiableListView) return _serviceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceIds);
}

@override final  String? slotId;
@override final  String? paymentMethodId;
@override@JsonKey() final  bool submissionInFlight;

/// Create a copy of CheckoutDraftModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutDraftModelCopyWith<_CheckoutDraftModel> get copyWith => __$CheckoutDraftModelCopyWithImpl<_CheckoutDraftModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckoutDraftModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutDraftModel&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey)&&const DeepCollectionEquality().equals(other.serviceIds, _serviceIds)&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.paymentMethodId, paymentMethodId) || other.paymentMethodId == paymentMethodId)&&(identical(other.submissionInFlight, submissionInFlight) || other.submissionInFlight == submissionInFlight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,idempotencyKey,const DeepCollectionEquality().hash(_serviceIds),slotId,paymentMethodId,submissionInFlight);
}

@override
String toString() {
    return 'CheckoutDraftModel(idempotencyKey: $idempotencyKey, serviceIds: $serviceIds, slotId: $slotId, paymentMethodId: $paymentMethodId, submissionInFlight: $submissionInFlight)';
}


}

/// @nodoc
abstract mixin class _$CheckoutDraftModelCopyWith<$Res> implements $CheckoutDraftModelCopyWith<$Res> {
  factory _$CheckoutDraftModelCopyWith(_CheckoutDraftModel value, $Res Function(_CheckoutDraftModel) _then) = __$CheckoutDraftModelCopyWithImpl;
@override @useResult
$Res call({
 String idempotencyKey, List<String> serviceIds, String? slotId, String? paymentMethodId, bool submissionInFlight
});




}
/// @nodoc
class __$CheckoutDraftModelCopyWithImpl<$Res>
    implements _$CheckoutDraftModelCopyWith<$Res> {
  __$CheckoutDraftModelCopyWithImpl(this._self, this._then);

  final _CheckoutDraftModel _self;
  final $Res Function(_CheckoutDraftModel) _then;

/// Create a copy of CheckoutDraftModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idempotencyKey = null,Object? serviceIds = null,Object? slotId = freezed,Object? paymentMethodId = freezed,Object? submissionInFlight = null,}) {
  return _then(_CheckoutDraftModel(
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
