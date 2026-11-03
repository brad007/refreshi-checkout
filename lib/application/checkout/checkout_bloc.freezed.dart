// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CheckoutEvent()';
}


}

/// @nodoc
class $CheckoutEventCopyWith<$Res>  {
$CheckoutEventCopyWith(CheckoutEvent _, $Res Function(CheckoutEvent) __);
}


/// Adds pattern-matching-related methods to [CheckoutEvent].
extension CheckoutEventPatterns on CheckoutEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CheckoutStarted value)?  started,TResult Function( CheckoutServiceToggled value)?  serviceToggled,TResult Function( CheckoutSlotSelected value)?  slotSelected,TResult Function( CheckoutPaymentMethodSelected value)?  paymentMethodSelected,TResult Function( CheckoutCatalogAvailable value)?  catalogAvailable,TResult Function( CheckoutSubmitted value)?  submitted,TResult Function( CheckoutNewCheckoutRequested value)?  newCheckoutRequested,TResult Function( CheckoutRetryRequested value)?  retryRequested,TResult Function( CheckoutPlacementHandled value)?  placementHandled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CheckoutStarted() when started != null:
return started(_that);case CheckoutServiceToggled() when serviceToggled != null:
return serviceToggled(_that);case CheckoutSlotSelected() when slotSelected != null:
return slotSelected(_that);case CheckoutPaymentMethodSelected() when paymentMethodSelected != null:
return paymentMethodSelected(_that);case CheckoutCatalogAvailable() when catalogAvailable != null:
return catalogAvailable(_that);case CheckoutSubmitted() when submitted != null:
return submitted(_that);case CheckoutNewCheckoutRequested() when newCheckoutRequested != null:
return newCheckoutRequested(_that);case CheckoutRetryRequested() when retryRequested != null:
return retryRequested(_that);case CheckoutPlacementHandled() when placementHandled != null:
return placementHandled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CheckoutStarted value)  started,required TResult Function( CheckoutServiceToggled value)  serviceToggled,required TResult Function( CheckoutSlotSelected value)  slotSelected,required TResult Function( CheckoutPaymentMethodSelected value)  paymentMethodSelected,required TResult Function( CheckoutCatalogAvailable value)  catalogAvailable,required TResult Function( CheckoutSubmitted value)  submitted,required TResult Function( CheckoutNewCheckoutRequested value)  newCheckoutRequested,required TResult Function( CheckoutRetryRequested value)  retryRequested,required TResult Function( CheckoutPlacementHandled value)  placementHandled,}){
final _that = this;
switch (_that) {
case CheckoutStarted():
return started(_that);case CheckoutServiceToggled():
return serviceToggled(_that);case CheckoutSlotSelected():
return slotSelected(_that);case CheckoutPaymentMethodSelected():
return paymentMethodSelected(_that);case CheckoutCatalogAvailable():
return catalogAvailable(_that);case CheckoutSubmitted():
return submitted(_that);case CheckoutNewCheckoutRequested():
return newCheckoutRequested(_that);case CheckoutRetryRequested():
return retryRequested(_that);case CheckoutPlacementHandled():
return placementHandled(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CheckoutStarted value)?  started,TResult? Function( CheckoutServiceToggled value)?  serviceToggled,TResult? Function( CheckoutSlotSelected value)?  slotSelected,TResult? Function( CheckoutPaymentMethodSelected value)?  paymentMethodSelected,TResult? Function( CheckoutCatalogAvailable value)?  catalogAvailable,TResult? Function( CheckoutSubmitted value)?  submitted,TResult? Function( CheckoutNewCheckoutRequested value)?  newCheckoutRequested,TResult? Function( CheckoutRetryRequested value)?  retryRequested,TResult? Function( CheckoutPlacementHandled value)?  placementHandled,}){
final _that = this;
switch (_that) {
case CheckoutStarted() when started != null:
return started(_that);case CheckoutServiceToggled() when serviceToggled != null:
return serviceToggled(_that);case CheckoutSlotSelected() when slotSelected != null:
return slotSelected(_that);case CheckoutPaymentMethodSelected() when paymentMethodSelected != null:
return paymentMethodSelected(_that);case CheckoutCatalogAvailable() when catalogAvailable != null:
return catalogAvailable(_that);case CheckoutSubmitted() when submitted != null:
return submitted(_that);case CheckoutNewCheckoutRequested() when newCheckoutRequested != null:
return newCheckoutRequested(_that);case CheckoutRetryRequested() when retryRequested != null:
return retryRequested(_that);case CheckoutPlacementHandled() when placementHandled != null:
return placementHandled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String serviceId)?  serviceToggled,TResult Function( String slotId)?  slotSelected,TResult Function( String paymentMethodId)?  paymentMethodSelected,TResult Function( CheckoutCatalog catalog)?  catalogAvailable,TResult Function()?  submitted,TResult Function()?  newCheckoutRequested,TResult Function( List<String> serviceIds,  String? slotId)?  retryRequested,TResult Function()?  placementHandled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CheckoutStarted() when started != null:
return started();case CheckoutServiceToggled() when serviceToggled != null:
return serviceToggled(_that.serviceId);case CheckoutSlotSelected() when slotSelected != null:
return slotSelected(_that.slotId);case CheckoutPaymentMethodSelected() when paymentMethodSelected != null:
return paymentMethodSelected(_that.paymentMethodId);case CheckoutCatalogAvailable() when catalogAvailable != null:
return catalogAvailable(_that.catalog);case CheckoutSubmitted() when submitted != null:
return submitted();case CheckoutNewCheckoutRequested() when newCheckoutRequested != null:
return newCheckoutRequested();case CheckoutRetryRequested() when retryRequested != null:
return retryRequested(_that.serviceIds,_that.slotId);case CheckoutPlacementHandled() when placementHandled != null:
return placementHandled();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String serviceId)  serviceToggled,required TResult Function( String slotId)  slotSelected,required TResult Function( String paymentMethodId)  paymentMethodSelected,required TResult Function( CheckoutCatalog catalog)  catalogAvailable,required TResult Function()  submitted,required TResult Function()  newCheckoutRequested,required TResult Function( List<String> serviceIds,  String? slotId)  retryRequested,required TResult Function()  placementHandled,}) {final _that = this;
switch (_that) {
case CheckoutStarted():
return started();case CheckoutServiceToggled():
return serviceToggled(_that.serviceId);case CheckoutSlotSelected():
return slotSelected(_that.slotId);case CheckoutPaymentMethodSelected():
return paymentMethodSelected(_that.paymentMethodId);case CheckoutCatalogAvailable():
return catalogAvailable(_that.catalog);case CheckoutSubmitted():
return submitted();case CheckoutNewCheckoutRequested():
return newCheckoutRequested();case CheckoutRetryRequested():
return retryRequested(_that.serviceIds,_that.slotId);case CheckoutPlacementHandled():
return placementHandled();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String serviceId)?  serviceToggled,TResult? Function( String slotId)?  slotSelected,TResult? Function( String paymentMethodId)?  paymentMethodSelected,TResult? Function( CheckoutCatalog catalog)?  catalogAvailable,TResult? Function()?  submitted,TResult? Function()?  newCheckoutRequested,TResult? Function( List<String> serviceIds,  String? slotId)?  retryRequested,TResult? Function()?  placementHandled,}) {final _that = this;
switch (_that) {
case CheckoutStarted() when started != null:
return started();case CheckoutServiceToggled() when serviceToggled != null:
return serviceToggled(_that.serviceId);case CheckoutSlotSelected() when slotSelected != null:
return slotSelected(_that.slotId);case CheckoutPaymentMethodSelected() when paymentMethodSelected != null:
return paymentMethodSelected(_that.paymentMethodId);case CheckoutCatalogAvailable() when catalogAvailable != null:
return catalogAvailable(_that.catalog);case CheckoutSubmitted() when submitted != null:
return submitted();case CheckoutNewCheckoutRequested() when newCheckoutRequested != null:
return newCheckoutRequested();case CheckoutRetryRequested() when retryRequested != null:
return retryRequested(_that.serviceIds,_that.slotId);case CheckoutPlacementHandled() when placementHandled != null:
return placementHandled();case _:
  return null;

}
}

}

/// @nodoc


class CheckoutStarted implements CheckoutEvent {
  const CheckoutStarted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CheckoutEvent.started()';
}


}




/// @nodoc


class CheckoutServiceToggled implements CheckoutEvent {
  const CheckoutServiceToggled(this.serviceId);
  

 final  String serviceId;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutServiceToggledCopyWith<CheckoutServiceToggled> get copyWith => _$CheckoutServiceToggledCopyWithImpl<CheckoutServiceToggled>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutServiceToggled&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,serviceId);
}

@override
String toString() {
    return 'CheckoutEvent.serviceToggled(serviceId: $serviceId)';
}


}

/// @nodoc
abstract mixin class $CheckoutServiceToggledCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutServiceToggledCopyWith(CheckoutServiceToggled value, $Res Function(CheckoutServiceToggled) _then) = _$CheckoutServiceToggledCopyWithImpl;
@useResult
$Res call({
 String serviceId
});




}
/// @nodoc
class _$CheckoutServiceToggledCopyWithImpl<$Res>
    implements $CheckoutServiceToggledCopyWith<$Res> {
  _$CheckoutServiceToggledCopyWithImpl(this._self, this._then);

  final CheckoutServiceToggled _self;
  final $Res Function(CheckoutServiceToggled) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? serviceId = null,}) {
  return _then(CheckoutServiceToggled(
null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CheckoutSlotSelected implements CheckoutEvent {
  const CheckoutSlotSelected(this.slotId);
  

 final  String slotId;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutSlotSelectedCopyWith<CheckoutSlotSelected> get copyWith => _$CheckoutSlotSelectedCopyWithImpl<CheckoutSlotSelected>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSlotSelected&&(identical(other.slotId, slotId) || other.slotId == slotId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,slotId);
}

@override
String toString() {
    return 'CheckoutEvent.slotSelected(slotId: $slotId)';
}


}

/// @nodoc
abstract mixin class $CheckoutSlotSelectedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutSlotSelectedCopyWith(CheckoutSlotSelected value, $Res Function(CheckoutSlotSelected) _then) = _$CheckoutSlotSelectedCopyWithImpl;
@useResult
$Res call({
 String slotId
});




}
/// @nodoc
class _$CheckoutSlotSelectedCopyWithImpl<$Res>
    implements $CheckoutSlotSelectedCopyWith<$Res> {
  _$CheckoutSlotSelectedCopyWithImpl(this._self, this._then);

  final CheckoutSlotSelected _self;
  final $Res Function(CheckoutSlotSelected) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? slotId = null,}) {
  return _then(CheckoutSlotSelected(
null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CheckoutPaymentMethodSelected implements CheckoutEvent {
  const CheckoutPaymentMethodSelected(this.paymentMethodId);
  

 final  String paymentMethodId;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutPaymentMethodSelectedCopyWith<CheckoutPaymentMethodSelected> get copyWith => _$CheckoutPaymentMethodSelectedCopyWithImpl<CheckoutPaymentMethodSelected>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutPaymentMethodSelected&&(identical(other.paymentMethodId, paymentMethodId) || other.paymentMethodId == paymentMethodId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,paymentMethodId);
}

@override
String toString() {
    return 'CheckoutEvent.paymentMethodSelected(paymentMethodId: $paymentMethodId)';
}


}

/// @nodoc
abstract mixin class $CheckoutPaymentMethodSelectedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutPaymentMethodSelectedCopyWith(CheckoutPaymentMethodSelected value, $Res Function(CheckoutPaymentMethodSelected) _then) = _$CheckoutPaymentMethodSelectedCopyWithImpl;
@useResult
$Res call({
 String paymentMethodId
});




}
/// @nodoc
class _$CheckoutPaymentMethodSelectedCopyWithImpl<$Res>
    implements $CheckoutPaymentMethodSelectedCopyWith<$Res> {
  _$CheckoutPaymentMethodSelectedCopyWithImpl(this._self, this._then);

  final CheckoutPaymentMethodSelected _self;
  final $Res Function(CheckoutPaymentMethodSelected) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paymentMethodId = null,}) {
  return _then(CheckoutPaymentMethodSelected(
null == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CheckoutCatalogAvailable implements CheckoutEvent {
  const CheckoutCatalogAvailable(this.catalog);
  

 final  CheckoutCatalog catalog;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutCatalogAvailableCopyWith<CheckoutCatalogAvailable> get copyWith => _$CheckoutCatalogAvailableCopyWithImpl<CheckoutCatalogAvailable>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutCatalogAvailable&&(identical(other.catalog, catalog) || other.catalog == catalog));
}


@override
int get hashCode {
    return Object.hash(runtimeType,catalog);
}

@override
String toString() {
    return 'CheckoutEvent.catalogAvailable(catalog: $catalog)';
}


}

/// @nodoc
abstract mixin class $CheckoutCatalogAvailableCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutCatalogAvailableCopyWith(CheckoutCatalogAvailable value, $Res Function(CheckoutCatalogAvailable) _then) = _$CheckoutCatalogAvailableCopyWithImpl;
@useResult
$Res call({
 CheckoutCatalog catalog
});


$CheckoutCatalogCopyWith<$Res> get catalog;

}
/// @nodoc
class _$CheckoutCatalogAvailableCopyWithImpl<$Res>
    implements $CheckoutCatalogAvailableCopyWith<$Res> {
  _$CheckoutCatalogAvailableCopyWithImpl(this._self, this._then);

  final CheckoutCatalogAvailable _self;
  final $Res Function(CheckoutCatalogAvailable) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? catalog = null,}) {
  return _then(CheckoutCatalogAvailable(
null == catalog ? _self.catalog : catalog // ignore: cast_nullable_to_non_nullable
as CheckoutCatalog,
  ));
}

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckoutCatalogCopyWith<$Res> get catalog {
  
  return $CheckoutCatalogCopyWith<$Res>(_self.catalog, (value) {
    return _then(_self.copyWith(catalog: value));
  });
}
}

/// @nodoc


class CheckoutSubmitted implements CheckoutEvent {
  const CheckoutSubmitted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CheckoutEvent.submitted()';
}


}




/// @nodoc


class CheckoutNewCheckoutRequested implements CheckoutEvent {
  const CheckoutNewCheckoutRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutNewCheckoutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CheckoutEvent.newCheckoutRequested()';
}


}




/// @nodoc


class CheckoutRetryRequested implements CheckoutEvent {
  const CheckoutRetryRequested({required  List<String> serviceIds, this.slotId}): _serviceIds = serviceIds;
  

 final  List<String> _serviceIds;
 List<String> get serviceIds {
  if (_serviceIds is EqualUnmodifiableListView) return _serviceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceIds);
}

 final  String? slotId;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutRetryRequestedCopyWith<CheckoutRetryRequested> get copyWith => _$CheckoutRetryRequestedCopyWithImpl<CheckoutRetryRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutRetryRequested&&const DeepCollectionEquality().equals(other.serviceIds, _serviceIds)&&(identical(other.slotId, slotId) || other.slotId == slotId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_serviceIds),slotId);
}

@override
String toString() {
    return 'CheckoutEvent.retryRequested(serviceIds: $serviceIds, slotId: $slotId)';
}


}

/// @nodoc
abstract mixin class $CheckoutRetryRequestedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutRetryRequestedCopyWith(CheckoutRetryRequested value, $Res Function(CheckoutRetryRequested) _then) = _$CheckoutRetryRequestedCopyWithImpl;
@useResult
$Res call({
 List<String> serviceIds, String? slotId
});




}
/// @nodoc
class _$CheckoutRetryRequestedCopyWithImpl<$Res>
    implements $CheckoutRetryRequestedCopyWith<$Res> {
  _$CheckoutRetryRequestedCopyWithImpl(this._self, this._then);

  final CheckoutRetryRequested _self;
  final $Res Function(CheckoutRetryRequested) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? serviceIds = null,Object? slotId = freezed,}) {
  return _then(CheckoutRetryRequested(
serviceIds: null == serviceIds ? _self._serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<String>,slotId: freezed == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class CheckoutPlacementHandled implements CheckoutEvent {
  const CheckoutPlacementHandled();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutPlacementHandled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CheckoutEvent.placementHandled()';
}


}




/// @nodoc
mixin _$CheckoutState {

 CheckoutStatus get status; CheckoutDraft? get draft; Failure? get failure;/// Set when an order was placed; the page navigates to it.
 OrderPlacement? get placement;/// True when the submission was resumed automatically after a reload.
 bool get resumed;
/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutStateCopyWith<CheckoutState> get copyWith => _$CheckoutStateCopyWithImpl<CheckoutState>(this as CheckoutState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CheckoutState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.draft, _this.draft) || other.draft == _this.draft)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.placement, _this.placement) || other.placement == _this.placement)&&(identical(other.resumed, _this.resumed) || other.resumed == _this.resumed));
}


@override
int get hashCode {
  final _this = this as CheckoutState;
  return Object.hash(runtimeType,_this.status,_this.draft,_this.failure,_this.placement,_this.resumed);
}

@override
String toString() {
  final _this = this as CheckoutState;
  return 'CheckoutState(status: ${_this.status}, draft: ${_this.draft}, failure: ${_this.failure}, placement: ${_this.placement}, resumed: ${_this.resumed})';
}


}

/// @nodoc
abstract mixin class $CheckoutStateCopyWith<$Res>  {
  factory $CheckoutStateCopyWith(CheckoutState value, $Res Function(CheckoutState) _then) = _$CheckoutStateCopyWithImpl;
@useResult
$Res call({
 CheckoutStatus status, CheckoutDraft? draft, Failure? failure, OrderPlacement? placement, bool resumed
});


$CheckoutDraftCopyWith<$Res>? get draft;$FailureCopyWith<$Res>? get failure;$OrderPlacementCopyWith<$Res>? get placement;

}
/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._self, this._then);

  final CheckoutState _self;
  final $Res Function(CheckoutState) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? draft = freezed,Object? failure = freezed,Object? placement = freezed,Object? resumed = null,}) {
  return _then(CheckoutState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CheckoutStatus,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as CheckoutDraft?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,placement: freezed == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as OrderPlacement?,resumed: null == resumed ? _self.resumed : resumed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckoutDraftCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $CheckoutDraftCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of CheckoutState
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
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderPlacementCopyWith<$Res>? get placement {
    if (_self.placement == null) {
    return null;
  }

  return $OrderPlacementCopyWith<$Res>(_self.placement!, (value) {
    return _then(_self.copyWith(placement: value));
  });
}
}


/// Adds pattern-matching-related methods to [CheckoutState].
extension CheckoutStatePatterns on CheckoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutState value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutState value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CheckoutStatus status,  CheckoutDraft? draft,  Failure? failure,  OrderPlacement? placement,  bool resumed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
return $default(_that.status,_that.draft,_that.failure,_that.placement,_that.resumed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CheckoutStatus status,  CheckoutDraft? draft,  Failure? failure,  OrderPlacement? placement,  bool resumed)  $default,) {final _that = this;
switch (_that) {
case _CheckoutState():
return $default(_that.status,_that.draft,_that.failure,_that.placement,_that.resumed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CheckoutStatus status,  CheckoutDraft? draft,  Failure? failure,  OrderPlacement? placement,  bool resumed)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
return $default(_that.status,_that.draft,_that.failure,_that.placement,_that.resumed);case _:
  return null;

}
}

}

/// @nodoc


class _CheckoutState extends CheckoutState {
  const _CheckoutState({this.status = CheckoutStatus.loading, this.draft, this.failure, this.placement, this.resumed = false}): super._();
  

@override@JsonKey() final  CheckoutStatus status;
@override final  CheckoutDraft? draft;
@override final  Failure? failure;
/// Set when an order was placed; the page navigates to it.
@override final  OrderPlacement? placement;
/// True when the submission was resumed automatically after a reload.
@override@JsonKey() final  bool resumed;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutStateCopyWith<_CheckoutState> get copyWith => __$CheckoutStateCopyWithImpl<_CheckoutState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutState&&(identical(other.status, status) || other.status == status)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.placement, placement) || other.placement == placement)&&(identical(other.resumed, resumed) || other.resumed == resumed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,draft,failure,placement,resumed);
}

@override
String toString() {
    return 'CheckoutState(status: $status, draft: $draft, failure: $failure, placement: $placement, resumed: $resumed)';
}


}

/// @nodoc
abstract mixin class _$CheckoutStateCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory _$CheckoutStateCopyWith(_CheckoutState value, $Res Function(_CheckoutState) _then) = __$CheckoutStateCopyWithImpl;
@override @useResult
$Res call({
 CheckoutStatus status, CheckoutDraft? draft, Failure? failure, OrderPlacement? placement, bool resumed
});


@override $CheckoutDraftCopyWith<$Res>? get draft;@override $FailureCopyWith<$Res>? get failure;@override $OrderPlacementCopyWith<$Res>? get placement;

}
/// @nodoc
class __$CheckoutStateCopyWithImpl<$Res>
    implements _$CheckoutStateCopyWith<$Res> {
  __$CheckoutStateCopyWithImpl(this._self, this._then);

  final _CheckoutState _self;
  final $Res Function(_CheckoutState) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? draft = freezed,Object? failure = freezed,Object? placement = freezed,Object? resumed = null,}) {
  return _then(_CheckoutState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CheckoutStatus,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as CheckoutDraft?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,placement: freezed == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as OrderPlacement?,resumed: null == resumed ? _self.resumed : resumed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckoutDraftCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $CheckoutDraftCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of CheckoutState
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
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderPlacementCopyWith<$Res>? get placement {
    if (_self.placement == null) {
    return null;
  }

  return $OrderPlacementCopyWith<$Res>(_self.placement!, (value) {
    return _then(_self.copyWith(placement: value));
  });
}
}

// dart format on
