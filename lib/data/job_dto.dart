import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_dto.freezed.dart';
part 'job_dto.g.dart';

//With freezed class: ells the code generator "build the immutable machinery for this class": ==, hashCode, copyWith, toString
@freezed
abstract class JobDto with _$JobDto {
  const factory JobDto({
    required String id,
    required String title,
    required String description,
    required String company,
    required String location,
    required String type,
    required DateTime postedAt,
    required bool isActive,
    double? salaryMin,
    double? salaryMax,
    required String companyId,
    required int applicationCount,
    DateTime? expiresAt,
    required String salaryDisplay,
  }) = _JobDto;

  factory JobDto.fromJson(Map<String, dynamic> json) => _$JobDtoFromJson(json);
}