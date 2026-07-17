// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_application_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobApplicationDto {

 String get id; String get jobTitle; String get company;@JsonKey(name: 'submittedAt') String get dateApplied; String get status;
/// Create a copy of JobApplicationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobApplicationDtoCopyWith<JobApplicationDto> get copyWith => _$JobApplicationDtoCopyWithImpl<JobApplicationDto>(this as JobApplicationDto, _$identity);

  /// Serializes this JobApplicationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobApplicationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.company, company) || other.company == company)&&(identical(other.dateApplied, dateApplied) || other.dateApplied == dateApplied)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobTitle,company,dateApplied,status);

@override
String toString() {
  return 'JobApplicationDto(id: $id, jobTitle: $jobTitle, company: $company, dateApplied: $dateApplied, status: $status)';
}


}

/// @nodoc
abstract mixin class $JobApplicationDtoCopyWith<$Res>  {
  factory $JobApplicationDtoCopyWith(JobApplicationDto value, $Res Function(JobApplicationDto) _then) = _$JobApplicationDtoCopyWithImpl;
@useResult
$Res call({
 String id, String jobTitle, String company,@JsonKey(name: 'submittedAt') String dateApplied, String status
});




}
/// @nodoc
class _$JobApplicationDtoCopyWithImpl<$Res>
    implements $JobApplicationDtoCopyWith<$Res> {
  _$JobApplicationDtoCopyWithImpl(this._self, this._then);

  final JobApplicationDto _self;
  final $Res Function(JobApplicationDto) _then;

/// Create a copy of JobApplicationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jobTitle = null,Object? company = null,Object? dateApplied = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,dateApplied: null == dateApplied ? _self.dateApplied : dateApplied // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JobApplicationDto].
extension JobApplicationDtoPatterns on JobApplicationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobApplicationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobApplicationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobApplicationDto value)  $default,){
final _that = this;
switch (_that) {
case _JobApplicationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobApplicationDto value)?  $default,){
final _that = this;
switch (_that) {
case _JobApplicationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String jobTitle,  String company, @JsonKey(name: 'submittedAt')  String dateApplied,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobApplicationDto() when $default != null:
return $default(_that.id,_that.jobTitle,_that.company,_that.dateApplied,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String jobTitle,  String company, @JsonKey(name: 'submittedAt')  String dateApplied,  String status)  $default,) {final _that = this;
switch (_that) {
case _JobApplicationDto():
return $default(_that.id,_that.jobTitle,_that.company,_that.dateApplied,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String jobTitle,  String company, @JsonKey(name: 'submittedAt')  String dateApplied,  String status)?  $default,) {final _that = this;
switch (_that) {
case _JobApplicationDto() when $default != null:
return $default(_that.id,_that.jobTitle,_that.company,_that.dateApplied,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobApplicationDto implements JobApplicationDto {
  const _JobApplicationDto({required this.id, required this.jobTitle, this.company = '', @JsonKey(name: 'submittedAt') required this.dateApplied, required this.status});
  factory _JobApplicationDto.fromJson(Map<String, dynamic> json) => _$JobApplicationDtoFromJson(json);

@override final  String id;
@override final  String jobTitle;
@override@JsonKey() final  String company;
@override@JsonKey(name: 'submittedAt') final  String dateApplied;
@override final  String status;

/// Create a copy of JobApplicationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobApplicationDtoCopyWith<_JobApplicationDto> get copyWith => __$JobApplicationDtoCopyWithImpl<_JobApplicationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobApplicationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobApplicationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.company, company) || other.company == company)&&(identical(other.dateApplied, dateApplied) || other.dateApplied == dateApplied)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobTitle,company,dateApplied,status);

@override
String toString() {
  return 'JobApplicationDto(id: $id, jobTitle: $jobTitle, company: $company, dateApplied: $dateApplied, status: $status)';
}


}

/// @nodoc
abstract mixin class _$JobApplicationDtoCopyWith<$Res> implements $JobApplicationDtoCopyWith<$Res> {
  factory _$JobApplicationDtoCopyWith(_JobApplicationDto value, $Res Function(_JobApplicationDto) _then) = __$JobApplicationDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String jobTitle, String company,@JsonKey(name: 'submittedAt') String dateApplied, String status
});




}
/// @nodoc
class __$JobApplicationDtoCopyWithImpl<$Res>
    implements _$JobApplicationDtoCopyWith<$Res> {
  __$JobApplicationDtoCopyWithImpl(this._self, this._then);

  final _JobApplicationDto _self;
  final $Res Function(_JobApplicationDto) _then;

/// Create a copy of JobApplicationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jobTitle = null,Object? company = null,Object? dateApplied = null,Object? status = null,}) {
  return _then(_JobApplicationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,dateApplied: null == dateApplied ? _self.dateApplied : dateApplied // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
