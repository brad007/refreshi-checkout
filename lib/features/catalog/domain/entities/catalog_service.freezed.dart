// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CatalogService {

 String get id; String get name; String get storeName; String get category; String get description; int get priceCents; int get originalPriceCents;
/// Create a copy of CatalogService
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogServiceCopyWith<CatalogService> get copyWith => _$CatalogServiceCopyWithImpl<CatalogService>(this as CatalogService, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CatalogService;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogService&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.storeName, _this.storeName) || other.storeName == _this.storeName)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.priceCents, _this.priceCents) || other.priceCents == _this.priceCents)&&(identical(other.originalPriceCents, _this.originalPriceCents) || other.originalPriceCents == _this.originalPriceCents));
}


@override
int get hashCode {
  final _this = this as CatalogService;
  return Object.hash(runtimeType,_this.id,_this.name,_this.storeName,_this.category,_this.description,_this.priceCents,_this.originalPriceCents);
}

@override
String toString() {
  final _this = this as CatalogService;
  return 'CatalogService(id: ${_this.id}, name: ${_this.name}, storeName: ${_this.storeName}, category: ${_this.category}, description: ${_this.description}, priceCents: ${_this.priceCents}, originalPriceCents: ${_this.originalPriceCents})';
}


}

/// @nodoc
abstract mixin class $CatalogServiceCopyWith<$Res>  {
  factory $CatalogServiceCopyWith(CatalogService value, $Res Function(CatalogService) _then) = _$CatalogServiceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String storeName, String category, String description, int priceCents, int originalPriceCents
});




}
/// @nodoc
class _$CatalogServiceCopyWithImpl<$Res>
    implements $CatalogServiceCopyWith<$Res> {
  _$CatalogServiceCopyWithImpl(this._self, this._then);

  final CatalogService _self;
  final $Res Function(CatalogService) _then;

/// Create a copy of CatalogService
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? storeName = null,Object? category = null,Object? description = null,Object? priceCents = null,Object? originalPriceCents = null,}) {
  return _then(CatalogService(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,originalPriceCents: null == originalPriceCents ? _self.originalPriceCents : originalPriceCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogService].
extension CatalogServicePatterns on CatalogService {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogService value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogService() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogService value)  $default,){
final _that = this;
switch (_that) {
case _CatalogService():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogService value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogService() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String storeName,  String category,  String description,  int priceCents,  int originalPriceCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogService() when $default != null:
return $default(_that.id,_that.name,_that.storeName,_that.category,_that.description,_that.priceCents,_that.originalPriceCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String storeName,  String category,  String description,  int priceCents,  int originalPriceCents)  $default,) {final _that = this;
switch (_that) {
case _CatalogService():
return $default(_that.id,_that.name,_that.storeName,_that.category,_that.description,_that.priceCents,_that.originalPriceCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String storeName,  String category,  String description,  int priceCents,  int originalPriceCents)?  $default,) {final _that = this;
switch (_that) {
case _CatalogService() when $default != null:
return $default(_that.id,_that.name,_that.storeName,_that.category,_that.description,_that.priceCents,_that.originalPriceCents);case _:
  return null;

}
}

}

/// @nodoc


class _CatalogService extends CatalogService {
  const _CatalogService({required this.id, required this.name, required this.storeName, required this.category, required this.description, required this.priceCents, required this.originalPriceCents}): super._();
  

@override final  String id;
@override final  String name;
@override final  String storeName;
@override final  String category;
@override final  String description;
@override final  int priceCents;
@override final  int originalPriceCents;

/// Create a copy of CatalogService
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogServiceCopyWith<_CatalogService> get copyWith => __$CatalogServiceCopyWithImpl<_CatalogService>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogService&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceCents, priceCents) || other.priceCents == priceCents)&&(identical(other.originalPriceCents, originalPriceCents) || other.originalPriceCents == originalPriceCents));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,storeName,category,description,priceCents,originalPriceCents);
}

@override
String toString() {
    return 'CatalogService(id: $id, name: $name, storeName: $storeName, category: $category, description: $description, priceCents: $priceCents, originalPriceCents: $originalPriceCents)';
}


}

/// @nodoc
abstract mixin class _$CatalogServiceCopyWith<$Res> implements $CatalogServiceCopyWith<$Res> {
  factory _$CatalogServiceCopyWith(_CatalogService value, $Res Function(_CatalogService) _then) = __$CatalogServiceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String storeName, String category, String description, int priceCents, int originalPriceCents
});




}
/// @nodoc
class __$CatalogServiceCopyWithImpl<$Res>
    implements _$CatalogServiceCopyWith<$Res> {
  __$CatalogServiceCopyWithImpl(this._self, this._then);

  final _CatalogService _self;
  final $Res Function(_CatalogService) _then;

/// Create a copy of CatalogService
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? storeName = null,Object? category = null,Object? description = null,Object? priceCents = null,Object? originalPriceCents = null,}) {
  return _then(_CatalogService(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceCents: null == priceCents ? _self.priceCents : priceCents // ignore: cast_nullable_to_non_nullable
as int,originalPriceCents: null == originalPriceCents ? _self.originalPriceCents : originalPriceCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
