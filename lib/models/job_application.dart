import 'package:freezed_annotation/freezed_annotation.dart';
import 'application_status.dart';

part 'job_application.freezed.dart';

@freezed
class JobApplication with _$JobApplication {
  const factory JobApplication({
    required String id,
    required String jobTitle,
    required String company,
    required DateTime dateApplied,
    required ApplicationStatus status,
  }) = _JobApplication;

  factory JobApplication.fromDto(JobApplicationDto dto) {
    return JobApplication(
      id: dto.id,
      jobTitle: dto.jobTitle,
      company: dto.company,
      dateApplied: DateTime.parse(dto.dateApplied),
      status: ApplicationStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == dto.status.toLowerCase(),
        orElse: () => ApplicationStatus.pending,
      ),
    );
  }
}
