// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobDto _$JobDtoFromJson(Map<String, dynamic> json) => _JobDto(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  company: json['company'] as String,
  location: json['location'] as String,
  type: json['type'] as String,
  postedAt: DateTime.parse(json['postedAt'] as String),
  isActive: json['isActive'] as bool,
  salaryMin: (json['salaryMin'] as num?)?.toDouble(),
  salaryMax: (json['salaryMax'] as num?)?.toDouble(),
  companyId: json['companyId'] as String,
  applicationCount: (json['applicationCount'] as num).toInt(),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  salaryDisplay: json['salaryDisplay'] as String,
);

Map<String, dynamic> _$JobDtoToJson(_JobDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'company': instance.company,
  'location': instance.location,
  'type': instance.type,
  'postedAt': instance.postedAt.toIso8601String(),
  'isActive': instance.isActive,
  'salaryMin': instance.salaryMin,
  'salaryMax': instance.salaryMax,
  'companyId': instance.companyId,
  'applicationCount': instance.applicationCount,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'salaryDisplay': instance.salaryDisplay,
};
