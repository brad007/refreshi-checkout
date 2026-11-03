// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerOrder {

 String get id; OrderStatus get status; List<OrderItem> get items; TimeSlot get slot; PaymentMethod get paymentMethod; int get totalCents; String get currency; PaymentHold get hold; List<TimelineEvent> get timeline; DateTime get createdAt;
/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerOrderCopyWith<CustomerOrder> get copyWith => _$CustomerOrderCopyWithImpl<CustomerOrder>(this as CustomerOrder, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CustomerOrder;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrder&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.slot, _this.slot) || other.slot == _this.slot)&&(identical(other.paymentMethod, _this.paymentMethod) || other.paymentMethod == _this.paymentMethod)&&(identical(other.totalCents, _this.totalCents) || other.totalCents == _this.totalCents)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.hold, _this.hold) || other.hold == _this.hold)&&const DeepCollectionEquality().equals(other.timeline, _this.timeline)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as CustomerOrder;
  return Object.hash(runtimeType,_this.id,_this.status,const DeepCollectionEquality().hash(_this.items),_this.slot,_this.paymentMethod,_this.totalCents,_this.currency,_this.hold,const DeepCollectionEquality().hash(_this.timeline),_this.createdAt);
}

@override
String toString() {
  final _this = this as CustomerOrder;
  return 'CustomerOrder(id: ${_this.id}, status: ${_this.status}, items: ${_this.items}, slot: ${_this.slot}, paymentMethod: ${_this.paymentMethod}, totalCents: ${_this.totalCents}, currency: ${_this.currency}, hold: ${_this.hold}, timeline: ${_this.timeline}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $CustomerOrderCopyWith<$Res>  {
  factory $CustomerOrderCopyWith(CustomerOrder value, $Res Function(CustomerOrder) _then) = _$CustomerOrderCopyWithImpl;
@useResult
$Res call({
 String id, OrderStatus status, List<OrderItem> items, TimeSlot slot, PaymentMethod paymentMethod, int totalCents, String currency, PaymentHold hold, List<TimelineEvent> timeline, DateTime createdAt
});


$TimeSlotCopyWith<$Res> get slot;$PaymentMethodCopyWith<$Res> get paymentMethod;$PaymentHoldCopyWith<$Res> get hold;

}
/// @nodoc
class _$CustomerOrderCopyWithImpl<$Res>
    implements $CustomerOrderCopyWith<$Res> {
  _$CustomerOrderCopyWithImpl(this._self, this._then);

  final CustomerOrder _self;
  final $Res Function(CustomerOrder) _then;

/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? items = null,Object? slot = null,Object? paymentMethod = null,Object? totalCents = null,Object? currency = null,Object? hold = null,Object? timeline = null,Object? createdAt = null,}) {
  return _then(CustomerOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as TimeSlot,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,totalCents: null == totalCents ? _self.totalCents : totalCents // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,hold: null == hold ? _self.hold : hold // ignore: cast_nullable_to_non_nullable
as PaymentHold,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TimelineEvent>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeSlotCopyWith<$Res> get slot {
  
  return $TimeSlotCopyWith<$Res>(_self.slot, (value) {
    return _then(_self.copyWith(slot: value));
  });
}/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentMethodCopyWith<$Res> get paymentMethod {
  
  return $PaymentMethodCopyWith<$Res>(_self.paymentMethod, (value) {
    return _then(_self.copyWith(paymentMethod: value));
  });
}/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentHoldCopyWith<$Res> get hold {
  
  return $PaymentHoldCopyWith<$Res>(_self.hold, (value) {
    return _then(_self.copyWith(hold: value));
  });
}
}


/// Adds pattern-matching-related methods to [CustomerOrder].
extension CustomerOrderPatterns on CustomerOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerOrder value)  $default,){
final _that = this;
switch (_that) {
case _CustomerOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerOrder value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  OrderStatus status,  List<OrderItem> items,  TimeSlot slot,  PaymentMethod paymentMethod,  int totalCents,  String currency,  PaymentHold hold,  List<TimelineEvent> timeline,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerOrder() when $default != null:
return $default(_that.id,_that.status,_that.items,_that.slot,_that.paymentMethod,_that.totalCents,_that.currency,_that.hold,_that.timeline,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  OrderStatus status,  List<OrderItem> items,  TimeSlot slot,  PaymentMethod paymentMethod,  int totalCents,  String currency,  PaymentHold hold,  List<TimelineEvent> timeline,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _CustomerOrder():
return $default(_that.id,_that.status,_that.items,_that.slot,_that.paymentMethod,_that.totalCents,_that.currency,_that.hold,_that.timeline,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  OrderStatus status,  List<OrderItem> items,  TimeSlot slot,  PaymentMethod paymentMethod,  int totalCents,  String currency,  PaymentHold hold,  List<TimelineEvent> timeline,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CustomerOrder() when $default != null:
return $default(_that.id,_that.status,_that.items,_that.slot,_that.paymentMethod,_that.totalCents,_that.currency,_that.hold,_that.timeline,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerOrder extends CustomerOrder {
  const _CustomerOrder({required this.id, required this.status, required  List<OrderItem> items, required this.slot, required this.paymentMethod, required this.totalCents, required this.currency, required this.hold, required  List<TimelineEvent> timeline, required this.createdAt}): _items = items,_timeline = timeline,super._();
  

@override final  String id;
@override final  OrderStatus status;
 final  List<OrderItem> _items;
@override List<OrderItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  TimeSlot slot;
@override final  PaymentMethod paymentMethod;
@override final  int totalCents;
@override final  String currency;
@override final  PaymentHold hold;
 final  List<TimelineEvent> _timeline;
@override List<TimelineEvent> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}

@override final  DateTime createdAt;

/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerOrderCopyWith<_CustomerOrder> get copyWith => __$CustomerOrderCopyWithImpl<_CustomerOrder>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.totalCents, totalCents) || other.totalCents == totalCents)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.hold, hold) || other.hold == hold)&&const DeepCollectionEquality().equals(other.timeline, _timeline)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,status,const DeepCollectionEquality().hash(_items),slot,paymentMethod,totalCents,currency,hold,const DeepCollectionEquality().hash(_timeline),createdAt);
}

@override
String toString() {
    return 'CustomerOrder(id: $id, status: $status, items: $items, slot: $slot, paymentMethod: $paymentMethod, totalCents: $totalCents, currency: $currency, hold: $hold, timeline: $timeline, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CustomerOrderCopyWith<$Res> implements $CustomerOrderCopyWith<$Res> {
  factory _$CustomerOrderCopyWith(_CustomerOrder value, $Res Function(_CustomerOrder) _then) = __$CustomerOrderCopyWithImpl;
@override @useResult
$Res call({
 String id, OrderStatus status, List<OrderItem> items, TimeSlot slot, PaymentMethod paymentMethod, int totalCents, String currency, PaymentHold hold, List<TimelineEvent> timeline, DateTime createdAt
});


@override $TimeSlotCopyWith<$Res> get slot;@override $PaymentMethodCopyWith<$Res> get paymentMethod;@override $PaymentHoldCopyWith<$Res> get hold;

}
/// @nodoc
class __$CustomerOrderCopyWithImpl<$Res>
    implements _$CustomerOrderCopyWith<$Res> {
  __$CustomerOrderCopyWithImpl(this._self, this._then);

  final _CustomerOrder _self;
  final $Res Function(_CustomerOrder) _then;

/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? items = null,Object? slot = null,Object? paymentMethod = null,Object? totalCents = null,Object? currency = null,Object? hold = null,Object? timeline = null,Object? createdAt = null,}) {
  return _then(_CustomerOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as TimeSlot,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,totalCents: null == totalCents ? _self.totalCents : totalCents // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,hold: null == hold ? _self.hold : hold // ignore: cast_nullable_to_non_nullable
as PaymentHold,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TimelineEvent>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeSlotCopyWith<$Res> get slot {
  
  return $TimeSlotCopyWith<$Res>(_self.slot, (value) {
    return _then(_self.copyWith(slot: value));
  });
}/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentMethodCopyWith<$Res> get paymentMethod {
  
  return $PaymentMethodCopyWith<$Res>(_self.paymentMethod, (value) {
    return _then(_self.copyWith(paymentMethod: value));
  });
}/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentHoldCopyWith<$Res> get hold {
  
  return $PaymentHoldCopyWith<$Res>(_self.hold, (value) {
    return _then(_self.copyWith(hold: value));
  });
}
}

/// @nodoc
mixin _$OrderItem {

 String get serviceId; String get name; int get priceCents;
/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderItemCopyWith<OrderItem> get copyWith => _$OrderItemCopyWithImpl<OrderItem>(this as OrderItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OrderItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderItem&&(identical(other.serviceId, _this.serviceId) || other.serviceId == _this.serviceId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.priceCents, _this.priceCents) || other.priceCents == _this.priceCents));
}


@override
int get hashCode {
  final _this = this as OrderItem;
  return Object.hash(runtimeType,_this.serviceId,_this.name,_this.priceCents);
}

@override
String toString() {
  final _this = this as OrderItem;
  return 'OrderItem(serviceId: ${_this.serviceId}, name: ${_this.name}, priceCents: ${_this.priceCents})';
}


}

/// @nodoc
abstract mixin class $OrderItemCopyWith<$Res>  {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) _then) = _$OrderItemCopyWithImpl;
@useResult
$Res call({
 String serviceId, String name, int priceCents
});




}
/// @nodoc
class _$OrderItemCopyWithImpl<$Res>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._self, this._then);

  final OrderItem _self;
  final $Res Function(OrderItem) _then;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceId = null,Object? name = null,Object? priceCents = null,}) {
  return _then(OrderItem(
serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderItem].
extension OrderItemPatterns on OrderItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderItem value)  $default,){
final _that = this;
switch (_that) {
case _OrderItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderItem value)?  $default,){
final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serviceId,  String name,  int priceCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
return $default(_that.serviceId,_that.name,_that.priceCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serviceId,  String name,  int priceCents)  $default,) {final _that = this;
switch (_that) {
case _OrderItem():
return $default(_that.serviceId,_that.name,_that.priceCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serviceId,  String name,  int priceCents)?  $default,) {final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
return $default(_that.serviceId,_that.name,_that.priceCents);case _:
  return null;

}
}

}

/// @nodoc


class _OrderItem implements OrderItem {
  const _OrderItem({required this.serviceId, required this.name, required this.priceCents});
  

@override final  String serviceId;
@override final  String name;
@override final  int priceCents;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderItemCopyWith<_OrderItem> get copyWith => __$OrderItemCopyWithImpl<_OrderItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderItem&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.name, name) || other.name == name)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents));
}


@override
int get hashCode {
    return Object.hash(runtimeType,serviceId,name,priceCents);
}

@override
String toString() {
    return 'OrderItem(serviceId: $serviceId, name: $name, priceCents: $priceCents)';
}


}

/// @nodoc
abstract mixin class _$OrderItemCopyWith<$Res> implements $OrderItemCopyWith<$Res> {
  factory _$OrderItemCopyWith(_OrderItem value, $Res Function(_OrderItem) _then) = __$OrderItemCopyWithImpl;
@override @useResult
$Res call({
 String serviceId, String name, int priceCents
});




}
/// @nodoc
class __$OrderItemCopyWithImpl<$Res>
    implements _$OrderItemCopyWith<$Res> {
  __$OrderItemCopyWithImpl(this._self, this._then);

  final _OrderItem _self;
  final $Res Function(_OrderItem) _then;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceId = null,Object? name = null,Object? priceCents = null,}) {
  return _then(_OrderItem(
serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PaymentHold {

 String get id; HoldStatus get status; int get amountCents;/// The provider that holds the funds: Peach Payments.
 String get provider;/// Peach `paymentType`; `PA` is a pre-authorisation.
 String get paymentType;/// Peach's payment id, for support and reconciliation.
 String get reference;/// Peach result code and description, e.g. `000.100.110`.
 String get resultCode; String get resultDescription;
/// Create a copy of PaymentHold
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentHoldCopyWith<PaymentHold> get copyWith => _$PaymentHoldCopyWithImpl<PaymentHold>(this as PaymentHold, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PaymentHold;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentHold&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.amountCents, _this.amountCents) || other.amountCents == _this.amountCents)&&(identical(other.provider, _this.provider) || other.provider == _this.provider)&&(identical(other.paymentType, _this.paymentType) || other.paymentType == _this.paymentType)&&(identical(other.reference, _this.reference) || other.reference == _this.reference)&&(identical(other.resultCode, _this.resultCode) || other.resultCode == _this.resultCode)&&(identical(other.resultDescription, _this.resultDescription) || other.resultDescription == _this.resultDescription));
}


@override
int get hashCode {
  final _this = this as PaymentHold;
  return Object.hash(runtimeType,_this.id,_this.status,_this.amountCents,_this.provider,_this.paymentType,_this.reference,_this.resultCode,_this.resultDescription);
}

@override
String toString() {
  final _this = this as PaymentHold;
  return 'PaymentHold(id: ${_this.id}, status: ${_this.status}, amountCents: ${_this.amountCents}, provider: ${_this.provider}, paymentType: ${_this.paymentType}, reference: ${_this.reference}, resultCode: ${_this.resultCode}, resultDescription: ${_this.resultDescription})';
}


}

/// @nodoc
abstract mixin class $PaymentHoldCopyWith<$Res>  {
  factory $PaymentHoldCopyWith(PaymentHold value, $Res Function(PaymentHold) _then) = _$PaymentHoldCopyWithImpl;
@useResult
$Res call({
 String id, HoldStatus status, int amountCents, String provider, String paymentType, String reference, String resultCode, String resultDescription
});




}
/// @nodoc
class _$PaymentHoldCopyWithImpl<$Res>
    implements $PaymentHoldCopyWith<$Res> {
  _$PaymentHoldCopyWithImpl(this._self, this._then);

  final PaymentHold _self;
  final $Res Function(PaymentHold) _then;

/// Create a copy of PaymentHold
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? amountCents = null,Object? provider = null,Object? paymentType = null,Object? reference = null,Object? resultCode = null,Object? resultDescription = null,}) {
  return _then(PaymentHold(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HoldStatus,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,paymentType: null == paymentType ? _self.paymentType : paymentType // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,resultCode: null == resultCode ? _self.resultCode : resultCode // ignore: cast_nullable_to_non_nullable
as String,resultDescription: null == resultDescription ? _self.resultDescription : resultDescription // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentHold].
extension PaymentHoldPatterns on PaymentHold {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentHold value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentHold() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentHold value)  $default,){
final _that = this;
switch (_that) {
case _PaymentHold():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentHold value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentHold() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  HoldStatus status,  int amountCents,  String provider,  String paymentType,  String reference,  String resultCode,  String resultDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentHold() when $default != null:
return $default(_that.id,_that.status,_that.amountCents,_that.provider,_that.paymentType,_that.reference,_that.resultCode,_that.resultDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  HoldStatus status,  int amountCents,  String provider,  String paymentType,  String reference,  String resultCode,  String resultDescription)  $default,) {final _that = this;
switch (_that) {
case _PaymentHold():
return $default(_that.id,_that.status,_that.amountCents,_that.provider,_that.paymentType,_that.reference,_that.resultCode,_that.resultDescription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  HoldStatus status,  int amountCents,  String provider,  String paymentType,  String reference,  String resultCode,  String resultDescription)?  $default,) {final _that = this;
switch (_that) {
case _PaymentHold() when $default != null:
return $default(_that.id,_that.status,_that.amountCents,_that.provider,_that.paymentType,_that.reference,_that.resultCode,_that.resultDescription);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentHold implements PaymentHold {
  const _PaymentHold({required this.id, required this.status, required this.amountCents, this.provider = 'PEACH_PAYMENTS', this.paymentType = 'PA', this.reference = '', this.resultCode = '', this.resultDescription = ''});
  

@override final  String id;
@override final  HoldStatus status;
@override final  int amountCents;
/// The provider that holds the funds: Peach Payments.
@override@JsonKey() final  String provider;
/// Peach `paymentType`; `PA` is a pre-authorisation.
@override@JsonKey() final  String paymentType;
/// Peach's payment id, for support and reconciliation.
@override@JsonKey() final  String reference;
/// Peach result code and description, e.g. `000.100.110`.
@override@JsonKey() final  String resultCode;
@override@JsonKey() final  String resultDescription;

/// Create a copy of PaymentHold
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentHoldCopyWith<_PaymentHold> get copyWith => __$PaymentHoldCopyWithImpl<_PaymentHold>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentHold&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.paymentType, paymentType) || other.paymentType == paymentType)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.resultCode, resultCode) || other.resultCode == resultCode)&&(identical(other.resultDescription, resultDescription) || other.resultDescription == resultDescription));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,status,amountCents,provider,paymentType,reference,resultCode,resultDescription);
}

@override
String toString() {
    return 'PaymentHold(id: $id, status: $status, amountCents: $amountCents, provider: $provider, paymentType: $paymentType, reference: $reference, resultCode: $resultCode, resultDescription: $resultDescription)';
}


}

/// @nodoc
abstract mixin class _$PaymentHoldCopyWith<$Res> implements $PaymentHoldCopyWith<$Res> {
  factory _$PaymentHoldCopyWith(_PaymentHold value, $Res Function(_PaymentHold) _then) = __$PaymentHoldCopyWithImpl;
@override @useResult
$Res call({
 String id, HoldStatus status, int amountCents, String provider, String paymentType, String reference, String resultCode, String resultDescription
});




}
/// @nodoc
class __$PaymentHoldCopyWithImpl<$Res>
    implements _$PaymentHoldCopyWith<$Res> {
  __$PaymentHoldCopyWithImpl(this._self, this._then);

  final _PaymentHold _self;
  final $Res Function(_PaymentHold) _then;

/// Create a copy of PaymentHold
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? amountCents = null,Object? provider = null,Object? paymentType = null,Object? reference = null,Object? resultCode = null,Object? resultDescription = null,}) {
  return _then(_PaymentHold(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HoldStatus,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,paymentType: null == paymentType ? _self.paymentType : paymentType // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,resultCode: null == resultCode ? _self.resultCode : resultCode // ignore: cast_nullable_to_non_nullable
as String,resultDescription: null == resultDescription ? _self.resultDescription : resultDescription // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TimelineEvent {

 TimelineEventType get type; DateTime get at;
/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineEventCopyWith<TimelineEvent> get copyWith => _$TimelineEventCopyWithImpl<TimelineEvent>(this as TimelineEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TimelineEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineEvent&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.at, _this.at) || other.at == _this.at));
}


@override
int get hashCode {
  final _this = this as TimelineEvent;
  return Object.hash(runtimeType,_this.type,_this.at);
}

@override
String toString() {
  final _this = this as TimelineEvent;
  return 'TimelineEvent(type: ${_this.type}, at: ${_this.at})';
}


}

/// @nodoc
abstract mixin class $TimelineEventCopyWith<$Res>  {
  factory $TimelineEventCopyWith(TimelineEvent value, $Res Function(TimelineEvent) _then) = _$TimelineEventCopyWithImpl;
@useResult
$Res call({
 TimelineEventType type, DateTime at
});




}
/// @nodoc
class _$TimelineEventCopyWithImpl<$Res>
    implements $TimelineEventCopyWith<$Res> {
  _$TimelineEventCopyWithImpl(this._self, this._then);

  final TimelineEvent _self;
  final $Res Function(TimelineEvent) _then;

/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? at = null,}) {
  return _then(TimelineEvent(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TimelineEventType,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TimelineEvent].
extension TimelineEventPatterns on TimelineEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimelineEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimelineEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimelineEvent value)  $default,){
final _that = this;
switch (_that) {
case _TimelineEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimelineEvent value)?  $default,){
final _that = this;
switch (_that) {
case _TimelineEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TimelineEventType type,  DateTime at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimelineEvent() when $default != null:
return $default(_that.type,_that.at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TimelineEventType type,  DateTime at)  $default,) {final _that = this;
switch (_that) {
case _TimelineEvent():
return $default(_that.type,_that.at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TimelineEventType type,  DateTime at)?  $default,) {final _that = this;
switch (_that) {
case _TimelineEvent() when $default != null:
return $default(_that.type,_that.at);case _:
  return null;

}
}

}

/// @nodoc


class _TimelineEvent implements TimelineEvent {
  const _TimelineEvent({required this.type, required this.at});
  

@override final  TimelineEventType type;
@override final  DateTime at;

/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimelineEventCopyWith<_TimelineEvent> get copyWith => __$TimelineEventCopyWithImpl<_TimelineEvent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimelineEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.at, at) || other.at == at));
}


@override
int get hashCode {
    return Object.hash(runtimeType,type,at);
}

@override
String toString() {
    return 'TimelineEvent(type: $type, at: $at)';
}


}

/// @nodoc
abstract mixin class _$TimelineEventCopyWith<$Res> implements $TimelineEventCopyWith<$Res> {
  factory _$TimelineEventCopyWith(_TimelineEvent value, $Res Function(_TimelineEvent) _then) = __$TimelineEventCopyWithImpl;
@override @useResult
$Res call({
 TimelineEventType type, DateTime at
});




}
/// @nodoc
class __$TimelineEventCopyWithImpl<$Res>
    implements _$TimelineEventCopyWith<$Res> {
  __$TimelineEventCopyWithImpl(this._self, this._then);

  final _TimelineEvent _self;
  final $Res Function(_TimelineEvent) _then;

/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? at = null,}) {
  return _then(_TimelineEvent(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TimelineEventType,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
