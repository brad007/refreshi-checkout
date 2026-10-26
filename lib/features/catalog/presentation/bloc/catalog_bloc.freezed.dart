// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CatalogEvent {

 bool get forceRefresh;
/// Create a copy of CatalogEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogEventCopyWith<CatalogEvent> get copyWith => _$CatalogEventCopyWithImpl<CatalogEvent>(this as CatalogEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CatalogEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogEvent&&(identical(other.forceRefresh, _this.forceRefresh) || other.forceRefresh == _this.forceRefresh));
}


@override
int get hashCode {
  final _this = this as CatalogEvent;
  return Object.hash(runtimeType,_this.forceRefresh);
}

@override
String toString() {
  final _this = this as CatalogEvent;
  return 'CatalogEvent(forceRefresh: ${_this.forceRefresh})';
}


}

/// @nodoc
abstract mixin class $CatalogEventCopyWith<$Res>  {
  factory $CatalogEventCopyWith(CatalogEvent value, $Res Function(CatalogEvent) _then) = _$CatalogEventCopyWithImpl;
@useResult
$Res call({
 bool forceRefresh
});




}
/// @nodoc
class _$CatalogEventCopyWithImpl<$Res>
    implements $CatalogEventCopyWith<$Res> {
  _$CatalogEventCopyWithImpl(this._self, this._then);

  final CatalogEvent _self;
  final $Res Function(CatalogEvent) _then;

/// Create a copy of CatalogEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? forceRefresh = null,}) {
  return _then(CatalogEvent.requested(
forceRefresh: null == forceRefresh ? _self.forceRefresh : forceRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogEvent].
extension CatalogEventPatterns on CatalogEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CatalogRequested value)?  requested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CatalogRequested() when requested != null:
return requested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CatalogRequested value)  requested,}){
final _that = this;
switch (_that) {
case CatalogRequested():
return requested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CatalogRequested value)?  requested,}){
final _that = this;
switch (_that) {
case CatalogRequested() when requested != null:
return requested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool forceRefresh)?  requested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CatalogRequested() when requested != null:
return requested(_that.forceRefresh);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool forceRefresh)  requested,}) {final _that = this;
switch (_that) {
case CatalogRequested():
return requested(_that.forceRefresh);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool forceRefresh)?  requested,}) {final _that = this;
switch (_that) {
case CatalogRequested() when requested != null:
return requested(_that.forceRefresh);case _:
  return null;

}
}

}

/// @nodoc


class CatalogRequested implements CatalogEvent {
  const CatalogRequested({this.forceRefresh = false});
  

@override@JsonKey() final  bool forceRefresh;

/// Create a copy of CatalogEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogRequestedCopyWith<CatalogRequested> get copyWith => _$CatalogRequestedCopyWithImpl<CatalogRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogRequested&&(identical(other.forceRefresh, forceRefresh) || other.forceRefresh == forceRefresh));
}


@override
int get hashCode {
    return Object.hash(runtimeType,forceRefresh);
}

@override
String toString() {
    return 'CatalogEvent.requested(forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $CatalogRequestedCopyWith<$Res> implements $CatalogEventCopyWith<$Res> {
  factory $CatalogRequestedCopyWith(CatalogRequested value, $Res Function(CatalogRequested) _then) = _$CatalogRequestedCopyWithImpl;
@override @useResult
$Res call({
 bool forceRefresh
});




}
/// @nodoc
class _$CatalogRequestedCopyWithImpl<$Res>
    implements $CatalogRequestedCopyWith<$Res> {
  _$CatalogRequestedCopyWithImpl(this._self, this._then);

  final CatalogRequested _self;
  final $Res Function(CatalogRequested) _then;

/// Create a copy of CatalogEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? forceRefresh = null,}) {
  return _then(CatalogRequested(
forceRefresh: null == forceRefresh ? _self.forceRefresh : forceRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$CatalogState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CatalogState()';
}


}

/// @nodoc
class $CatalogStateCopyWith<$Res>  {
$CatalogStateCopyWith(CatalogState _, $Res Function(CatalogState) __);
}


/// Adds pattern-matching-related methods to [CatalogState].
extension CatalogStatePatterns on CatalogState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CatalogInitial value)?  initial,TResult Function( CatalogLoading value)?  loading,TResult Function( CatalogLoaded value)?  loaded,TResult Function( CatalogFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CatalogInitial() when initial != null:
return initial(_that);case CatalogLoading() when loading != null:
return loading(_that);case CatalogLoaded() when loaded != null:
return loaded(_that);case CatalogFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CatalogInitial value)  initial,required TResult Function( CatalogLoading value)  loading,required TResult Function( CatalogLoaded value)  loaded,required TResult Function( CatalogFailure value)  failure,}){
final _that = this;
switch (_that) {
case CatalogInitial():
return initial(_that);case CatalogLoading():
return loading(_that);case CatalogLoaded():
return loaded(_that);case CatalogFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CatalogInitial value)?  initial,TResult? Function( CatalogLoading value)?  loading,TResult? Function( CatalogLoaded value)?  loaded,TResult? Function( CatalogFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CatalogInitial() when initial != null:
return initial(_that);case CatalogLoading() when loading != null:
return loading(_that);case CatalogLoaded() when loaded != null:
return loaded(_that);case CatalogFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( CheckoutCatalog catalog)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CatalogInitial() when initial != null:
return initial();case CatalogLoading() when loading != null:
return loading();case CatalogLoaded() when loaded != null:
return loaded(_that.catalog);case CatalogFailure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( CheckoutCatalog catalog)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case CatalogInitial():
return initial();case CatalogLoading():
return loading();case CatalogLoaded():
return loaded(_that.catalog);case CatalogFailure():
return failure(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( CheckoutCatalog catalog)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case CatalogInitial() when initial != null:
return initial();case CatalogLoading() when loading != null:
return loading();case CatalogLoaded() when loaded != null:
return loaded(_that.catalog);case CatalogFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class CatalogInitial implements CatalogState {
  const CatalogInitial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CatalogState.initial()';
}


}




/// @nodoc


class CatalogLoading implements CatalogState {
  const CatalogLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CatalogState.loading()';
}


}




/// @nodoc


class CatalogLoaded implements CatalogState {
  const CatalogLoaded(this.catalog);
  

 final  CheckoutCatalog catalog;

/// Create a copy of CatalogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogLoadedCopyWith<CatalogLoaded> get copyWith => _$CatalogLoadedCopyWithImpl<CatalogLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogLoaded&&(identical(other.catalog, catalog) || other.catalog == catalog));
}


@override
int get hashCode {
    return Object.hash(runtimeType,catalog);
}

@override
String toString() {
    return 'CatalogState.loaded(catalog: $catalog)';
}


}

/// @nodoc
abstract mixin class $CatalogLoadedCopyWith<$Res> implements $CatalogStateCopyWith<$Res> {
  factory $CatalogLoadedCopyWith(CatalogLoaded value, $Res Function(CatalogLoaded) _then) = _$CatalogLoadedCopyWithImpl;
@useResult
$Res call({
 CheckoutCatalog catalog
});


$CheckoutCatalogCopyWith<$Res> get catalog;

}
/// @nodoc
class _$CatalogLoadedCopyWithImpl<$Res>
    implements $CatalogLoadedCopyWith<$Res> {
  _$CatalogLoadedCopyWithImpl(this._self, this._then);

  final CatalogLoaded _self;
  final $Res Function(CatalogLoaded) _then;

/// Create a copy of CatalogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? catalog = null,}) {
  return _then(CatalogLoaded(
null == catalog ? _self.catalog : catalog // ignore: cast_nullable_to_non_nullable
as CheckoutCatalog,
  ));
}

/// Create a copy of CatalogState
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


class CatalogFailure implements CatalogState {
  const CatalogFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of CatalogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogFailureCopyWith<CatalogFailure> get copyWith => _$CatalogFailureCopyWithImpl<CatalogFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,failure);
}

@override
String toString() {
    return 'CatalogState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $CatalogFailureCopyWith<$Res> implements $CatalogStateCopyWith<$Res> {
  factory $CatalogFailureCopyWith(CatalogFailure value, $Res Function(CatalogFailure) _then) = _$CatalogFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$CatalogFailureCopyWithImpl<$Res>
    implements $CatalogFailureCopyWith<$Res> {
  _$CatalogFailureCopyWithImpl(this._self, this._then);

  final CatalogFailure _self;
  final $Res Function(CatalogFailure) _then;

/// Create a copy of CatalogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(CatalogFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of CatalogState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
