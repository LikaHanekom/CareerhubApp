import 'package:isar_community/isar.dart';
import '../models/application_status.dart';
import '../models/job_application.dart';

part 'job_application_isar.g.dart';

@Collection() //
class JobApplicationIsar {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String applicationId;

  late String jobTitle;
  late String company;
  late DateTime dateApplied;
  late String status;

  // Converts Isar entity back to the Domain Model
  JobApplication toDomain() {
    return JobApplication(
      id: applicationId,
      jobTitle: jobTitle,
      company: company,
      dateApplied: dateApplied,
      status: ApplicationStatus.values.firstWhere(
            (e) => e.name.toLowerCase() == status.toLowerCase(),
        orElse: () => ApplicationStatus.pending,
      ),
    );
  }

  // Creates an Isar entity from the Domain Model
  static JobApplicationIsar fromDomain(JobApplication domain) {
    return JobApplicationIsar()
      ..applicationId = domain.id
      ..jobTitle = domain.jobTitle
      ..company = domain.company
      ..dateApplied = domain.dateApplied
      ..status = domain.status.name;
  }
}


