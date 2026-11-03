// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure()';
}


}

/// @nodoc
class $FailureCopyWith<$Res>  {
$FailureCopyWith(Failure _, $Res Function(Failure) __);
}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServerFailure value)?  server,TResult Function( NetworkFailure value)?  network,TResult Function( CacheFailure value)?  cache,TResult Function( NotFoundFailure value)?  notFound,TResult Function( InvalidInputFailure value)?  invalidInput,TResult Function( IdempotencyConflictFailure value)?  idempotencyConflict,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that);case NetworkFailure() when network != null:
return network(_that);case CacheFailure() when cache != null:
return cache(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case InvalidInputFailure() when invalidInput != null:
return invalidInput(_that);case IdempotencyConflictFailure() when idempotencyConflict != null:
return idempotencyConflict(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServerFailure value)  server,required TResult Function( NetworkFailure value)  network,required TResult Function( CacheFailure value)  cache,required TResult Function( NotFoundFailure value)  notFound,required TResult Function( InvalidInputFailure value)  invalidInput,required TResult Function( IdempotencyConflictFailure value)  idempotencyConflict,}){
final _that = this;
switch (_that) {
case ServerFailure():
return server(_that);case NetworkFailure():
return network(_that);case CacheFailure():
return cache(_that);case NotFoundFailure():
return notFound(_that);case InvalidInputFailure():
return invalidInput(_that);case IdempotencyConflictFailure():
return idempotencyConflict(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServerFailure value)?  server,TResult? Function( NetworkFailure value)?  network,TResult? Function( CacheFailure value)?  cache,TResult? Function( NotFoundFailure value)?  notFound,TResult? Function( InvalidInputFailure value)?  invalidInput,TResult? Function( IdempotencyConflictFailure value)?  idempotencyConflict,}){
final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that);case NetworkFailure() when network != null:
return network(_that);case CacheFailure() when cache != null:
return cache(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case InvalidInputFailure() when invalidInput != null:
return invalidInput(_that);case IdempotencyConflictFailure() when idempotencyConflict != null:
return idempotencyConflict(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? message)?  server,TResult Function()?  network,TResult Function()?  cache,TResult Function()?  notFound,TResult Function( String message)?  invalidInput,TResult Function( String? existingOrderId)?  idempotencyConflict,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that.message);case NetworkFailure() when network != null:
return network();case CacheFailure() when cache != null:
return cache();case NotFoundFailure() when notFound != null:
return notFound();case InvalidInputFailure() when invalidInput != null:
return invalidInput(_that.message);case IdempotencyConflictFailure() when idempotencyConflict != null:
return idempotencyConflict(_that.existingOrderId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? message)  server,required TResult Function()  network,required TResult Function()  cache,required TResult Function()  notFound,required TResult Function( String message)  invalidInput,required TResult Function( String? existingOrderId)  idempotencyConflict,}) {final _that = this;
switch (_that) {
case ServerFailure():
return server(_that.message);case NetworkFailure():
return network();case CacheFailure():
return cache();case NotFoundFailure():
return notFound();case InvalidInputFailure():
return invalidInput(_that.message);case IdempotencyConflictFailure():
return idempotencyConflict(_that.existingOrderId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? message)?  server,TResult? Function()?  network,TResult? Function()?  cache,TResult? Function()?  notFound,TResult? Function( String message)?  invalidInput,TResult? Function( String? existingOrderId)?  idempotencyConflict,}) {final _that = this;
switch (_that) {
case ServerFailure() when server != null:
return server(_that.message);case NetworkFailure() when network != null:
return network();case CacheFailure() when cache != null:
return cache();case NotFoundFailure() when notFound != null:
return notFound();case InvalidInputFailure() when invalidInput != null:
return invalidInput(_that.message);case IdempotencyConflictFailure() when idempotencyConflict != null:
return idempotencyConflict(_that.existingOrderId);case _:
  return null;

}
}

}

/// @nodoc


class ServerFailure extends Failure {
  const ServerFailure({this.message}): super._();
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'Failure.server(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(ServerFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class NetworkFailure extends Failure {
  const NetworkFailure(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.network()';
}


}




/// @nodoc


class CacheFailure extends Failure {
  const CacheFailure(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.cache()';
}


}




/// @nodoc


class NotFoundFailure extends Failure {
  const NotFoundFailure(): super._();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFoundFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'Failure.notFound()';
}


}




/// @nodoc


class InvalidInputFailure extends Failure {
  const InvalidInputFailure({required this.message}): super._();
  

 final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidInputFailureCopyWith<InvalidInputFailure> get copyWith => _$InvalidInputFailureCopyWithImpl<InvalidInputFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidInputFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'Failure.invalidInput(message: $message)';
}


}

/// @nodoc
abstract mixin class $InvalidInputFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $InvalidInputFailureCopyWith(InvalidInputFailure value, $Res Function(InvalidInputFailure) _then) = _$InvalidInputFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$InvalidInputFailureCopyWithImpl<$Res>
    implements $InvalidInputFailureCopyWith<$Res> {
  _$InvalidInputFailureCopyWithImpl(this._self, this._then);

  final InvalidInputFailure _self;
  final $Res Function(InvalidInputFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(InvalidInputFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class IdempotencyConflictFailure extends Failure {
  const IdempotencyConflictFailure({this.existingOrderId}): super._();
  

 final  String? existingOrderId;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IdempotencyConflictFailureCopyWith<IdempotencyConflictFailure> get copyWith => _$IdempotencyConflictFailureCopyWithImpl<IdempotencyConflictFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is IdempotencyConflictFailure&&(identical(other.existingOrderId, existingOrderId) || other.existingOrderId == existingOrderId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,existingOrderId);
}

@override
String toString() {
    return 'Failure.idempotencyConflict(existingOrderId: $existingOrderId)';
}


}

/// @nodoc
abstract mixin class $IdempotencyConflictFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $IdempotencyConflictFailureCopyWith(IdempotencyConflictFailure value, $Res Function(IdempotencyConflictFailure) _then) = _$IdempotencyConflictFailureCopyWithImpl;
@useResult
$Res call({
 String? existingOrderId
});




}
/// @nodoc
class _$IdempotencyConflictFailureCopyWithImpl<$Res>
    implements $IdempotencyConflictFailureCopyWith<$Res> {
  _$IdempotencyConflictFailureCopyWithImpl(this._self, this._then);

  final IdempotencyConflictFailure _self;
  final $Res Function(IdempotencyConflictFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? existingOrderId = freezed,}) {
  return _then(IdempotencyConflictFailure(
existingOrderId: freezed == existingOrderId ? _self.existingOrderId : existingOrderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
