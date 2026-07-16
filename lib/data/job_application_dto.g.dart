// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_application_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobApplicationDto _$JobApplicationDtoFromJson(Map<String, dynamic> json) =>
    _JobApplicationDto(
      id: json['id'] as String,
      jobTitle: json['jobTitle'] as String,
      company: json['company'] as String,
      dateApplied: json['dateApplied'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$JobApplicationDtoToJson(_JobApplicationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobTitle': instance.jobTitle,
      'company': instance.company,
      'dateApplied': instance.dateApplied,
      'status': instance.status,
    };
