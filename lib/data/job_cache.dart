import 'package:isar_community/isar.dart';
import '../models/job.dart';

part 'job_cache.g.dart';

/// On-device storage representation of a job. Deliberately a third class,
/// separate from both JobDto (network boundary) and Job (domain layer):
/// @freezed generates a const, unnamed constructor with final fields, which
/// Isar's code generator cannot use — Isar requires a mutable, non-const
/// class with `late` fields it can populate reflectively when reading rows
/// back from disk. Neither DTO nor domain model can satisfy both
/// constraints at once, so storage gets its own class.
@Collection()
class JobCache {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String jobId;

  late String title;
  late String company;
  late String location;
  double? salary;
  late String employmentType;
  late bool isOpen;
  DateTime? closingDate;
  String? description;

  /// Converts this Isar row back into the domain model used by the rest
  /// of the app. isSaved is intentionally not stored here — bookmark state
  /// is tracked separately (see saved_jobs_notifier.dart), so it always
  /// starts false and is layered back on by the UI/provider that reads it.
  Job toDomain() {
    return Job(
      id: jobId,
      title: title,
      company: company,
      location: location,
      salary: salary,
      employmentType: employmentType,
      isOpen: isOpen,
      closingDate: closingDate,
      description: description,
    );
  }

  static JobCache fromDomain(Job domain) {
    return JobCache()
      ..jobId = domain.id
      ..title = domain.title
      ..company = domain.company
      ..location = domain.location
      ..salary = domain.salary
      ..employmentType = domain.employmentType
      ..isOpen = domain.isOpen
      ..closingDate = domain.closingDate
      ..description = domain.description;
  }
}
