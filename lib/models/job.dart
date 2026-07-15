import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/job_dto.dart';

part 'job.freezed.dart';

@freezed
abstract  class Job with _$Job {
  const Job._();//empty constructor that freezed needsif you'd want to add extra stuff

  const factory Job({
    required String id,
    required String title,
    required String company,
    required String location,
    double? salary,
    required String employmentType,
    required bool isOpen,
    DateTime? closingDate,
    String? description,
    @Default(false) bool isSaved,
  }) = _Job;

  bool get canApply => isOpen;

  String get displaySalary {
    if (salary == null) return 'Market-related';
    return 'R${salary!.toStringAsFixed(0)} per month';
  }

  bool matches(String query) {
    final q = query.toLowerCase();
    return title.toLowerCase().contains(q) ||
        company.toLowerCase().contains(q) ||
        location.toLowerCase().contains(q);
  }
//static method - calls the one real job()
  static Job remote({
    required String id,
    required String title,
    required String company,
    double? salary,
    required String employmentType,
    bool isOpen = true,
    DateTime? closingDate,
    String? description,
  }) {
    return Job(
      id: id,
      title: title,
      company: company,
      location: 'Remote',
      salary: salary,
      employmentType: employmentType,
      isOpen: isOpen,
      closingDate: closingDate,
      description: description,
    );
  }

  static Job closed({
    required String id,
    required String title,
    required String company,
    required String location,
    double? salary,
    required String employmentType,
    String? description,
  }) {
    return Job(
      id: id,
      title: title,
      company: company,
      location: location,
      salary: salary,
      employmentType: employmentType,
      isOpen: false,
      closingDate: null,
      description: description,
    );
  }

  static Job fromDto(JobDto dto) {
    final salary = dto.salaryMin ?? dto.salaryMax;
    return Job(
      id: dto.id,
      title: dto.title,
      company: dto.company,
      location: dto.location,
      salary: salary,
      employmentType: _mapEmploymentType(dto.type),
      isOpen: dto.isActive,
      closingDate: dto.expiresAt,
      description: dto.description,
    );
  }

  static String _mapEmploymentType(String apiType) {
    return switch (apiType) {
      'FullTime' => 'Full-time',
      'PartTime' => 'Part-time',
      'Contract' => 'Contract',
      'Internship' => 'Internship',
      _ => apiType,
    };
  }
}