import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_application_dto.freezed.dart';
part 'job_application_dto.g.dart';

@freezed
class JobApplicationDto with _$JobApplicationDto {
  const factory JobApplicationDto({
    required String id,
    required String jobTitle,
    required String company,
    required String dateApplied,
    required String status,
  }) = _JobApplicationDto;

  factory JobApplicationDto.fromJson(Map<String, dynamic> json) =>
      _$JobApplicationDtoFromJson(json);
}
