class Job {
  final String title;
  final String company;
  final String location;
  final double? salary;
  final String employmentType;
  final bool isOpen;
  final DateTime? closingDate;
  final String? description;

  const Job({
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
    return 'Job(title: $title, company: $company, location: $location, '
        'isOpen: $isOpen, salary: $displaySalary, '
        'closingDate: ${closingDate ?? "none"})';
  }
}