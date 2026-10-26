// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_placement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderPlacement {

 CustomerOrder get order; bool get replayed;
/// Create a copy of OrderPlacement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderPlacementCopyWith<OrderPlacement> get copyWith => _$OrderPlacementCopyWithImpl<OrderPlacement>(this as OrderPlacement, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OrderPlacement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderPlacement&&(identical(other.order, _this.order) || other.order == _this.order)&&(identical(other.replayed, _this.replayed) || other.replayed == _this.replayed));
}


@override
int get hashCode {
  final _this = this as OrderPlacement;
  return Object.hash(runtimeType,_this.order,_this.replayed);
}

@override
String toString() {
  final _this = this as OrderPlacement;
  return 'OrderPlacement(order: ${_this.order}, replayed: ${_this.replayed})';
}


}

/// @nodoc
abstract mixin class $OrderPlacementCopyWith<$Res>  {
  factory $OrderPlacementCopyWith(OrderPlacement value, $Res Function(OrderPlacement) _then) = _$OrderPlacementCopyWithImpl;
@useResult
$Res call({
 CustomerOrder order, bool replayed
});


$CustomerOrderCopyWith<$Res> get order;

}
/// @nodoc
class _$OrderPlacementCopyWithImpl<$Res>
    implements $OrderPlacementCopyWith<$Res> {
  _$OrderPlacementCopyWithImpl(this._self, this._then);

  final OrderPlacement _self;
  final $Res Function(OrderPlacement) _then;

/// Create a copy of OrderPlacement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? order = null,Object? replayed = null,}) {
  return _then(OrderPlacement(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as CustomerOrder,replayed: null == replayed ? _self.replayed : replayed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of OrderPlacement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerOrderCopyWith<$Res> get order {
  
  return $CustomerOrderCopyWith<$Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderPlacement].
extension OrderPlacementPatterns on OrderPlacement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderPlacement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderPlacement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderPlacement value)  $default,){
final _that = this;
switch (_that) {
case _OrderPlacement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderPlacement value)?  $default,){
final _that = this;
switch (_that) {
case _OrderPlacement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CustomerOrder order,  bool replayed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderPlacement() when $default != null:
return $default(_that.order,_that.replayed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CustomerOrder order,  bool replayed)  $default,) {final _that = this;
switch (_that) {
case _OrderPlacement():
return $default(_that.order,_that.replayed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CustomerOrder order,  bool replayed)?  $default,) {final _that = this;
switch (_that) {
case _OrderPlacement() when $default != null:
return $default(_that.order,_that.replayed);case _:
  return null;

}
}

}

/// @nodoc


class _OrderPlacement implements OrderPlacement {
  const _OrderPlacement({required this.order, required this.replayed});
  

@override final  CustomerOrder order;
@override final  bool replayed;

/// Create a copy of OrderPlacement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderPlacementCopyWith<_OrderPlacement> get copyWith => __$OrderPlacementCopyWithImpl<_OrderPlacement>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderPlacement&&(identical(other.order, order) || other.order == order)&&(identical(other.replayed, replayed) || other.replayed == replayed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,order,replayed);
}

@override
String toString() {
    return 'OrderPlacement(order: $order, replayed: $replayed)';
}


}

/// @nodoc
abstract mixin class _$OrderPlacementCopyWith<$Res> implements $OrderPlacementCopyWith<$Res> {
  factory _$OrderPlacementCopyWith(_OrderPlacement value, $Res Function(_OrderPlacement) _then) = __$OrderPlacementCopyWithImpl;
@override @useResult
$Res call({
 CustomerOrder order, bool replayed
});


@override $CustomerOrderCopyWith<$Res> get order;

}
/// @nodoc
class __$OrderPlacementCopyWithImpl<$Res>
    implements _$OrderPlacementCopyWith<$Res> {
  __$OrderPlacementCopyWithImpl(this._self, this._then);

  final _OrderPlacement _self;
  final $Res Function(_OrderPlacement) _then;

/// Create a copy of OrderPlacement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? order = null,Object? replayed = null,}) {
  return _then(_OrderPlacement(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as CustomerOrder,replayed: null == replayed ? _self.replayed : replayed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of OrderPlacement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerOrderCopyWith<$Res> get order {
  
  return $CustomerOrderCopyWith<$Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}
}

// dart format on
