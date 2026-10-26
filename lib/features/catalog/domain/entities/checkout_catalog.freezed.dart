// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutCatalog {

 List<CatalogService> get services; List<TimeSlot> get slots; List<PaymentMethod> get paymentMethods;
/// Create a copy of CheckoutCatalog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutCatalogCopyWith<CheckoutCatalog> get copyWith => _$CheckoutCatalogCopyWithImpl<CheckoutCatalog>(this as CheckoutCatalog, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CheckoutCatalog;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutCatalog&&const DeepCollectionEquality().equals(other.services, _this.services)&&const DeepCollectionEquality().equals(other.slots, _this.slots)&&const DeepCollectionEquality().equals(other.paymentMethods, _this.paymentMethods));
}


@override
int get hashCode {
  final _this = this as CheckoutCatalog;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.services),const DeepCollectionEquality().hash(_this.slots),const DeepCollectionEquality().hash(_this.paymentMethods));
}

@override
String toString() {
  final _this = this as CheckoutCatalog;
  return 'CheckoutCatalog(services: ${_this.services}, slots: ${_this.slots}, paymentMethods: ${_this.paymentMethods})';
}


}

/// @nodoc
abstract mixin class $CheckoutCatalogCopyWith<$Res>  {
  factory $CheckoutCatalogCopyWith(CheckoutCatalog value, $Res Function(CheckoutCatalog) _then) = _$CheckoutCatalogCopyWithImpl;
@useResult
$Res call({
 List<CatalogService> services, List<TimeSlot> slots, List<PaymentMethod> paymentMethods
});




}
/// @nodoc
class _$CheckoutCatalogCopyWithImpl<$Res>
    implements $CheckoutCatalogCopyWith<$Res> {
  _$CheckoutCatalogCopyWithImpl(this._self, this._then);

  final CheckoutCatalog _self;
  final $Res Function(CheckoutCatalog) _then;

/// Create a copy of CheckoutCatalog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? services = null,Object? slots = null,Object? paymentMethods = null,}) {
  return _then(CheckoutCatalog(
services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<CatalogService>,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<TimeSlot>,paymentMethods: null == paymentMethods ? _self.paymentMethods : paymentMethods // ignore: cast_nullable_to_non_nullable
as List<PaymentMethod>,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutCatalog].
extension CheckoutCatalogPatterns on CheckoutCatalog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutCatalog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutCatalog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutCatalog value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutCatalog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutCatalog value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutCatalog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CatalogService> services,  List<TimeSlot> slots,  List<PaymentMethod> paymentMethods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutCatalog() when $default != null:
return $default(_that.services,_that.slots,_that.paymentMethods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CatalogService> services,  List<TimeSlot> slots,  List<PaymentMethod> paymentMethods)  $default,) {final _that = this;
switch (_that) {
case _CheckoutCatalog():
return $default(_that.services,_that.slots,_that.paymentMethods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CatalogService> services,  List<TimeSlot> slots,  List<PaymentMethod> paymentMethods)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutCatalog() when $default != null:
return $default(_that.services,_that.slots,_that.paymentMethods);case _:
  return null;

}
}

}

/// @nodoc


class _CheckoutCatalog extends CheckoutCatalog {
  const _CheckoutCatalog({required  List<CatalogService> services, required  List<TimeSlot> slots, required  List<PaymentMethod> paymentMethods}): _services = services,_slots = slots,_paymentMethods = paymentMethods,super._();
  

 final  List<CatalogService> _services;
@override List<CatalogService> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}

 final  List<TimeSlot> _slots;
@override List<TimeSlot> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}

 final  List<PaymentMethod> _paymentMethods;
@override List<PaymentMethod> get paymentMethods {
  if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paymentMethods);
}


/// Create a copy of CheckoutCatalog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutCatalogCopyWith<_CheckoutCatalog> get copyWith => __$CheckoutCatalogCopyWithImpl<_CheckoutCatalog>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutCatalog&&const DeepCollectionEquality().equals(other.services, _services)&&const DeepCollectionEquality().equals(other.slots, _slots)&&const DeepCollectionEquality().equals(other.paymentMethods, _paymentMethods));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_services),const DeepCollectionEquality().hash(_slots),const DeepCollectionEquality().hash(_paymentMethods));
}

@override
String toString() {
    return 'CheckoutCatalog(services: $services, slots: $slots, paymentMethods: $paymentMethods)';
}


}

/// @nodoc
abstract mixin class _$CheckoutCatalogCopyWith<$Res> implements $CheckoutCatalogCopyWith<$Res> {
  factory _$CheckoutCatalogCopyWith(_CheckoutCatalog value, $Res Function(_CheckoutCatalog) _then) = __$CheckoutCatalogCopyWithImpl;
@override @useResult
$Res call({
 List<CatalogService> services, List<TimeSlot> slots, List<PaymentMethod> paymentMethods
});




}
/// @nodoc
class __$CheckoutCatalogCopyWithImpl<$Res>
    implements _$CheckoutCatalogCopyWith<$Res> {
  __$CheckoutCatalogCopyWithImpl(this._self, this._then);

  final _CheckoutCatalog _self;
  final $Res Function(_CheckoutCatalog) _then;

/// Create a copy of CheckoutCatalog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? services = null,Object? slots = null,Object? paymentMethods = null,}) {
  return _then(_CheckoutCatalog(
services: null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<CatalogService>,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<TimeSlot>,paymentMethods: null == paymentMethods ? _self._paymentMethods : paymentMethods // ignore: cast_nullable_to_non_nullable
as List<PaymentMethod>,
  ));
}


}

// dart format on
