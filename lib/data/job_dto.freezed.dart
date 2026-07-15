// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobDto {

 String get id; String get title; String get description; String get company; String get location; String get type; DateTime get postedAt; bool get isActive; double? get salaryMin; double? get salaryMax; String get companyId; int get applicationCount; DateTime? get expiresAt; String get salaryDisplay;
/// Create a copy of JobDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobDtoCopyWith<JobDto> get copyWith => _$JobDtoCopyWithImpl<JobDto>(this as JobDto, _$identity);

  /// Serializes this JobDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.type, type) || other.type == type)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.salaryMin, salaryMin) || other.salaryMin == salaryMin)&&(identical(other.salaryMax, salaryMax) || other.salaryMax == salaryMax)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.applicationCount, applicationCount) || other.applicationCount == applicationCount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.salaryDisplay, salaryDisplay) || other.salaryDisplay == salaryDisplay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,company,location,type,postedAt,isActive,salaryMin,salaryMax,companyId,applicationCount,expiresAt,salaryDisplay);

@override
String toString() {
  return 'JobDto(id: $id, title: $title, description: $description, company: $company, location: $location, type: $type, postedAt: $postedAt, isActive: $isActive, salaryMin: $salaryMin, salaryMax: $salaryMax, companyId: $companyId, applicationCount: $applicationCount, expiresAt: $expiresAt, salaryDisplay: $salaryDisplay)';
}


}

/// @nodoc
abstract mixin class $JobDtoCopyWith<$Res>  {
  factory $JobDtoCopyWith(JobDto value, $Res Function(JobDto) _then) = _$JobDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String company, String location, String type, DateTime postedAt, bool isActive, double? salaryMin, double? salaryMax, String companyId, int applicationCount, DateTime? expiresAt, String salaryDisplay
});




}
/// @nodoc
class _$JobDtoCopyWithImpl<$Res>
    implements $JobDtoCopyWith<$Res> {
  _$JobDtoCopyWithImpl(this._self, this._then);

  final JobDto _self;
  final $Res Function(JobDto) _then;

/// Create a copy of JobDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? company = null,Object? location = null,Object? type = null,Object? postedAt = null,Object? isActive = null,Object? salaryMin = freezed,Object? salaryMax = freezed,Object? companyId = null,Object? applicationCount = null,Object? expiresAt = freezed,Object? salaryDisplay = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,salaryMin: freezed == salaryMin ? _self.salaryMin : salaryMin // ignore: cast_nullable_to_non_nullable
as double?,salaryMax: freezed == salaryMax ? _self.salaryMax : salaryMax // ignore: cast_nullable_to_non_nullable
as double?,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,applicationCount: null == applicationCount ? _self.applicationCount : applicationCount // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,salaryDisplay: null == salaryDisplay ? _self.salaryDisplay : salaryDisplay // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JobDto].
extension JobDtoPatterns on JobDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobDto value)  $default,){
final _that = this;
switch (_that) {
case _JobDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobDto value)?  $default,){
final _that = this;
switch (_that) {
case _JobDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String company,  String location,  String type,  DateTime postedAt,  bool isActive,  double? salaryMin,  double? salaryMax,  String companyId,  int applicationCount,  DateTime? expiresAt,  String salaryDisplay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobDto() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.company,_that.location,_that.type,_that.postedAt,_that.isActive,_that.salaryMin,_that.salaryMax,_that.companyId,_that.applicationCount,_that.expiresAt,_that.salaryDisplay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String company,  String location,  String type,  DateTime postedAt,  bool isActive,  double? salaryMin,  double? salaryMax,  String companyId,  int applicationCount,  DateTime? expiresAt,  String salaryDisplay)  $default,) {final _that = this;
switch (_that) {
case _JobDto():
return $default(_that.id,_that.title,_that.description,_that.company,_that.location,_that.type,_that.postedAt,_that.isActive,_that.salaryMin,_that.salaryMax,_that.companyId,_that.applicationCount,_that.expiresAt,_that.salaryDisplay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String company,  String location,  String type,  DateTime postedAt,  bool isActive,  double? salaryMin,  double? salaryMax,  String companyId,  int applicationCount,  DateTime? expiresAt,  String salaryDisplay)?  $default,) {final _that = this;
switch (_that) {
case _JobDto() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.company,_that.location,_that.type,_that.postedAt,_that.isActive,_that.salaryMin,_that.salaryMax,_that.companyId,_that.applicationCount,_that.expiresAt,_that.salaryDisplay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobDto implements JobDto {
  const _JobDto({required this.id, required this.title, required this.description, required this.company, required this.location, required this.type, required this.postedAt, required this.isActive, this.salaryMin, this.salaryMax, required this.companyId, required this.applicationCount, this.expiresAt, required this.salaryDisplay});
  factory _JobDto.fromJson(Map<String, dynamic> json) => _$JobDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String company;
@override final  String location;
@override final  String type;
@override final  DateTime postedAt;
@override final  bool isActive;
@override final  double? salaryMin;
@override final  double? salaryMax;
@override final  String companyId;
@override final  int applicationCount;
@override final  DateTime? expiresAt;
@override final  String salaryDisplay;

/// Create a copy of JobDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobDtoCopyWith<_JobDto> get copyWith => __$JobDtoCopyWithImpl<_JobDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.type, type) || other.type == type)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.salaryMin, salaryMin) || other.salaryMin == salaryMin)&&(identical(other.salaryMax, salaryMax) || other.salaryMax == salaryMax)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.applicationCount, applicationCount) || other.applicationCount == applicationCount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.salaryDisplay, salaryDisplay) || other.salaryDisplay == salaryDisplay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,company,location,type,postedAt,isActive,salaryMin,salaryMax,companyId,applicationCount,expiresAt,salaryDisplay);

@override
String toString() {
  return 'JobDto(id: $id, title: $title, description: $description, company: $company, location: $location, type: $type, postedAt: $postedAt, isActive: $isActive, salaryMin: $salaryMin, salaryMax: $salaryMax, companyId: $companyId, applicationCount: $applicationCount, expiresAt: $expiresAt, salaryDisplay: $salaryDisplay)';
}


}

/// @nodoc
abstract mixin class _$JobDtoCopyWith<$Res> implements $JobDtoCopyWith<$Res> {
  factory _$JobDtoCopyWith(_JobDto value, $Res Function(_JobDto) _then) = __$JobDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String company, String location, String type, DateTime postedAt, bool isActive, double? salaryMin, double? salaryMax, String companyId, int applicationCount, DateTime? expiresAt, String salaryDisplay
});




}
/// @nodoc
class __$JobDtoCopyWithImpl<$Res>
    implements _$JobDtoCopyWith<$Res> {
  __$JobDtoCopyWithImpl(this._self, this._then);

  final _JobDto _self;
  final $Res Function(_JobDto) _then;

/// Create a copy of JobDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? company = null,Object? location = null,Object? type = null,Object? postedAt = null,Object? isActive = null,Object? salaryMin = freezed,Object? salaryMax = freezed,Object? companyId = null,Object? applicationCount = null,Object? expiresAt = freezed,Object? salaryDisplay = null,}) {
  return _then(_JobDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,salaryMin: freezed == salaryMin ? _self.salaryMin : salaryMin // ignore: cast_nullable_to_non_nullable
as double?,salaryMax: freezed == salaryMax ? _self.salaryMax : salaryMax // ignore: cast_nullable_to_non_nullable
as double?,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,applicationCount: null == applicationCount ? _self.applicationCount : applicationCount // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,salaryDisplay: null == salaryDisplay ? _self.salaryDisplay : salaryDisplay // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
