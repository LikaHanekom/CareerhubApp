import '../data/job_dto.dart';

class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final double? salary;
  final String employmentType;
  final bool isOpen;
  final DateTime? closingDate;
  final String? description;

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    this.salary,
    required this.employmentType,
    required this.isOpen,
    this.closingDate,
    this.description,
  });

  /// A job posted with no fixed physical location.
  Job.remote({
    required this.id,
    required this.title,
    required this.company,
    this.salary,
    required this.employmentType,
    this.isOpen = true,
    this.closingDate,
    this.description,
  }) : location = 'Remote';

  /// An employer manually closing a listing (e.g. position filled).
  Job.closed({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    this.salary,
    required this.employmentType,
    this.description,
  })  : isOpen = false,
        closingDate = null;

  bool get canApply => isOpen;

  String get displaySalary {
    if (salary == null) return 'Market-related';
    return 'R${salary!.toStringAsFixed(0)} per month';
  }

  @override
  String toString() {
    return 'Job(id: $id, title: $title, company: $company, location: $location, '
        'isOpen: $isOpen, salary: $displaySalary, '
        'closingDate: ${closingDate ?? "none"})';
  }

  Job copyWith({
    String? id,
    String? title,
    String? company,
    String? location,
    double? salary,
    String? employmentType,
    bool? isOpen,
    DateTime? closingDate,
    String? description,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      salary: salary ?? this.salary,
      employmentType: employmentType ?? this.employmentType,
      isOpen: isOpen ?? this.isOpen,
      closingDate: closingDate ?? this.closingDate,
      description: description ?? this.description,
    );
  }

  bool matches(String query) {
    final q = query.toLowerCase();
    return title.toLowerCase().contains(q) ||
        company.toLowerCase().contains(q) ||
        location.toLowerCase().contains(q);
  }

  factory Job.fromDto(JobDto dto) {
    double? salary = dto.salaryMin ?? dto.salaryMax;

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

  /// Translates the API's JobType enum wire values (e.g. "FullTime") into
  /// the display strings the UI's filter chips already compare against
  /// (e.g. "Full-time") — see Assignment 2.1 Q1 for why this mapping lives
  /// here rather than in the DTO.
  static String _mapEmploymentType(String apiType) {
    switch (apiType) {
      case 'FullTime':
        return 'Full-time';
      case 'PartTime':
        return 'Part-time';
      case 'Contract':
        return 'Contract';
      case 'Internship':
        return 'Internship';
      default:
        return apiType;
    }
  }
}