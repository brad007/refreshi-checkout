// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderDetailsEvent {

 String get orderId;
/// Create a copy of OrderDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsEventCopyWith<OrderDetailsEvent> get copyWith => _$OrderDetailsEventCopyWithImpl<OrderDetailsEvent>(this as OrderDetailsEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OrderDetailsEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsEvent&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId));
}


@override
int get hashCode {
  final _this = this as OrderDetailsEvent;
  return Object.hash(runtimeType,_this.orderId);
}

@override
String toString() {
  final _this = this as OrderDetailsEvent;
  return 'OrderDetailsEvent(orderId: ${_this.orderId})';
}


}

/// @nodoc
abstract mixin class $OrderDetailsEventCopyWith<$Res>  {
  factory $OrderDetailsEventCopyWith(OrderDetailsEvent value, $Res Function(OrderDetailsEvent) _then) = _$OrderDetailsEventCopyWithImpl;
@useResult
$Res call({
 String orderId
});




}
/// @nodoc
class _$OrderDetailsEventCopyWithImpl<$Res>
    implements $OrderDetailsEventCopyWith<$Res> {
  _$OrderDetailsEventCopyWithImpl(this._self, this._then);

  final OrderDetailsEvent _self;
  final $Res Function(OrderDetailsEvent) _then;

/// Create a copy of OrderDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,}) {
  return _then(OrderDetailsEvent.started(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderDetailsEvent].
extension OrderDetailsEventPatterns on OrderDetailsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrderDetailsStarted value)?  started,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrderDetailsStarted() when started != null:
return started(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrderDetailsStarted value)  started,}){
final _that = this;
switch (_that) {
case OrderDetailsStarted():
return started(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrderDetailsStarted value)?  started,}){
final _that = this;
switch (_that) {
case OrderDetailsStarted() when started != null:
return started(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String orderId)?  started,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrderDetailsStarted() when started != null:
return started(_that.orderId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String orderId)  started,}) {final _that = this;
switch (_that) {
case OrderDetailsStarted():
return started(_that.orderId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String orderId)?  started,}) {final _that = this;
switch (_that) {
case OrderDetailsStarted() when started != null:
return started(_that.orderId);case _:
  return null;

}
}

}

/// @nodoc


class OrderDetailsStarted implements OrderDetailsEvent {
  const OrderDetailsStarted(this.orderId);
  

@override final  String orderId;

/// Create a copy of OrderDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsStartedCopyWith<OrderDetailsStarted> get copyWith => _$OrderDetailsStartedCopyWithImpl<OrderDetailsStarted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsStarted&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,orderId);
}

@override
String toString() {
    return 'OrderDetailsEvent.started(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsStartedCopyWith<$Res> implements $OrderDetailsEventCopyWith<$Res> {
  factory $OrderDetailsStartedCopyWith(OrderDetailsStarted value, $Res Function(OrderDetailsStarted) _then) = _$OrderDetailsStartedCopyWithImpl;
@override @useResult
$Res call({
 String orderId
});




}
/// @nodoc
class _$OrderDetailsStartedCopyWithImpl<$Res>
    implements $OrderDetailsStartedCopyWith<$Res> {
  _$OrderDetailsStartedCopyWithImpl(this._self, this._then);

  final OrderDetailsStarted _self;
  final $Res Function(OrderDetailsStarted) _then;

/// Create a copy of OrderDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(OrderDetailsStarted(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$OrderDetailsState {

 OrderDetailsStatus get status; CustomerOrder? get order; Failure? get failure;/// True while subscribed to live updates for a pending hold.
 bool get isLive; Failure? get liveUpdateFailure;
/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsStateCopyWith<OrderDetailsState> get copyWith => _$OrderDetailsStateCopyWithImpl<OrderDetailsState>(this as OrderDetailsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OrderDetailsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.order, _this.order) || other.order == _this.order)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.isLive, _this.isLive) || other.isLive == _this.isLive)&&(identical(other.liveUpdateFailure, _this.liveUpdateFailure) || other.liveUpdateFailure == _this.liveUpdateFailure));
}


@override
int get hashCode {
  final _this = this as OrderDetailsState;
  return Object.hash(runtimeType,_this.status,_this.order,_this.failure,_this.isLive,_this.liveUpdateFailure);
}

@override
String toString() {
  final _this = this as OrderDetailsState;
  return 'OrderDetailsState(status: ${_this.status}, order: ${_this.order}, failure: ${_this.failure}, isLive: ${_this.isLive}, liveUpdateFailure: ${_this.liveUpdateFailure})';
}


}

/// @nodoc
abstract mixin class $OrderDetailsStateCopyWith<$Res>  {
  factory $OrderDetailsStateCopyWith(OrderDetailsState value, $Res Function(OrderDetailsState) _then) = _$OrderDetailsStateCopyWithImpl;
@useResult
$Res call({
 OrderDetailsStatus status, CustomerOrder? order, Failure? failure, bool isLive, Failure? liveUpdateFailure
});


$CustomerOrderCopyWith<$Res>? get order;$FailureCopyWith<$Res>? get failure;$FailureCopyWith<$Res>? get liveUpdateFailure;

}
/// @nodoc
class _$OrderDetailsStateCopyWithImpl<$Res>
    implements $OrderDetailsStateCopyWith<$Res> {
  _$OrderDetailsStateCopyWithImpl(this._self, this._then);

  final OrderDetailsState _self;
  final $Res Function(OrderDetailsState) _then;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? order = freezed,Object? failure = freezed,Object? isLive = null,Object? liveUpdateFailure = freezed,}) {
  return _then(OrderDetailsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderDetailsStatus,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as CustomerOrder?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isLive: null == isLive ? _self.isLive : isLive // ignore: cast_nullable_to_non_nullable
as bool,liveUpdateFailure: freezed == liveUpdateFailure ? _self.liveUpdateFailure : liveUpdateFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerOrderCopyWith<$Res>? get order {
    if (_self.order == null) {
    return null;
  }

  return $CustomerOrderCopyWith<$Res>(_self.order!, (value) {
    return _then(_self.copyWith(order: value));
  });
}/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get liveUpdateFailure {
    if (_self.liveUpdateFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.liveUpdateFailure!, (value) {
    return _then(_self.copyWith(liveUpdateFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderDetailsState].
extension OrderDetailsStatePatterns on OrderDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _OrderDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _OrderDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OrderDetailsStatus status,  CustomerOrder? order,  Failure? failure,  bool isLive,  Failure? liveUpdateFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderDetailsState() when $default != null:
return $default(_that.status,_that.order,_that.failure,_that.isLive,_that.liveUpdateFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OrderDetailsStatus status,  CustomerOrder? order,  Failure? failure,  bool isLive,  Failure? liveUpdateFailure)  $default,) {final _that = this;
switch (_that) {
case _OrderDetailsState():
return $default(_that.status,_that.order,_that.failure,_that.isLive,_that.liveUpdateFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OrderDetailsStatus status,  CustomerOrder? order,  Failure? failure,  bool isLive,  Failure? liveUpdateFailure)?  $default,) {final _that = this;
switch (_that) {
case _OrderDetailsState() when $default != null:
return $default(_that.status,_that.order,_that.failure,_that.isLive,_that.liveUpdateFailure);case _:
  return null;

}
}

}

/// @nodoc


class _OrderDetailsState implements OrderDetailsState {
  const _OrderDetailsState({this.status = OrderDetailsStatus.loading, this.order, this.failure, this.isLive = false, this.liveUpdateFailure});
  

@override@JsonKey() final  OrderDetailsStatus status;
@override final  CustomerOrder? order;
@override final  Failure? failure;
/// True while subscribed to live updates for a pending hold.
@override@JsonKey() final  bool isLive;
@override final  Failure? liveUpdateFailure;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderDetailsStateCopyWith<_OrderDetailsState> get copyWith => __$OrderDetailsStateCopyWithImpl<_OrderDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderDetailsState&&(identical(other.status, status) || other.status == status)&&(identical(other.order, order) || other.order == order)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isLive, isLive) || other.isLive == isLive)&&(identical(other.liveUpdateFailure, liveUpdateFailure) || other.liveUpdateFailure == liveUpdateFailure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,order,failure,isLive,liveUpdateFailure);
}

@override
String toString() {
    return 'OrderDetailsState(status: $status, order: $order, failure: $failure, isLive: $isLive, liveUpdateFailure: $liveUpdateFailure)';
}


}

/// @nodoc
abstract mixin class _$OrderDetailsStateCopyWith<$Res> implements $OrderDetailsStateCopyWith<$Res> {
  factory _$OrderDetailsStateCopyWith(_OrderDetailsState value, $Res Function(_OrderDetailsState) _then) = __$OrderDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 OrderDetailsStatus status, CustomerOrder? order, Failure? failure, bool isLive, Failure? liveUpdateFailure
});


@override $CustomerOrderCopyWith<$Res>? get order;@override $FailureCopyWith<$Res>? get failure;@override $FailureCopyWith<$Res>? get liveUpdateFailure;

}
/// @nodoc
class __$OrderDetailsStateCopyWithImpl<$Res>
    implements _$OrderDetailsStateCopyWith<$Res> {
  __$OrderDetailsStateCopyWithImpl(this._self, this._then);

  final _OrderDetailsState _self;
  final $Res Function(_OrderDetailsState) _then;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? order = freezed,Object? failure = freezed,Object? isLive = null,Object? liveUpdateFailure = freezed,}) {
  return _then(_OrderDetailsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderDetailsStatus,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as CustomerOrder?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isLive: null == isLive ? _self.isLive : isLive // ignore: cast_nullable_to_non_nullable
as bool,liveUpdateFailure: freezed == liveUpdateFailure ? _self.liveUpdateFailure : liveUpdateFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerOrderCopyWith<$Res>? get order {
    if (_self.order == null) {
    return null;
  }

  return $CustomerOrderCopyWith<$Res>(_self.order!, (value) {
    return _then(_self.copyWith(order: value));
  });
}/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get liveUpdateFailure {
    if (_self.liveUpdateFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.liveUpdateFailure!, (value) {
    return _then(_self.copyWith(liveUpdateFailure: value));
  });
}
}

// dart format on
