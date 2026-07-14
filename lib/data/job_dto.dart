class JobDto {
  final String id;
  final String title;
  final String description;
  final String company;
  final String location;
  final String type;
  final DateTime postedAt;
  final bool isActive;
  final double? salaryMin;
  final double? salaryMax;
  final String companyId;
  final int applicationCount;
  final DateTime? expiresAt;
  final String salaryDisplay;

  JobDto({
    required this.id,
    required this.title,
    required this.description,
    required this.company,
    required this.location,
    required this.type,
    required this.postedAt,
    required this.isActive,
    this.salaryMin,
    this.salaryMax,
    required this.companyId,
    required this.applicationCount,
    this.expiresAt,
    required this.salaryDisplay,
  });

  factory JobDto.fromJson(Map<String, dynamic> json) {
    return JobDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      // JobType is a C# enum — Dio/System.Text.Json usually serializes
      // enums as their string name unless configured otherwise.
      type: json['type'] as String,
      postedAt: DateTime.parse(json['postedAt'] as String),
      isActive: json['isActive'] as bool,
      salaryMin: (json['salaryMin'] as num?)?.toDouble(),
      salaryMax: (json['salaryMax'] as num?)?.toDouble(),
      companyId: json['companyId'] as String,
      applicationCount: json['applicationCount'] as int,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      salaryDisplay: json['salaryDisplay'] as String,
    );
  }
}