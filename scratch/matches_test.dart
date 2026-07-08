import '../lib/models/job.dart';

void main() {
  final jobs = [
    Job(title: 'Flutter Developer', company: 'CareerHub', location: 'Pretoria',
        employmentType: 'Full-time', isOpen: true),
    Job(title: 'Backend Intern', company: 'DataCo', location: 'Johannesburg',
        employmentType: 'Internship', isOpen: true),
    Job.closed(title: 'Product Designer', company: 'PixelWorks', location: 'Cape Town',
        employmentType: 'Full-time'),
    Job.remote(title: 'DevOps Engineer', company: 'CloudNine', employmentType: 'Contract'),
    Job(title: 'Data Analyst', company: 'InsightWorks', location: 'Durban',
        employmentType: 'Full-time', isOpen: true),
  ];

  // Query 1: matches title
  final flutterResults = jobs.where((j) => j.matches('flutter')).toList();
  assert(flutterResults.length == 1 && flutterResults.first.title == 'Flutter Developer');
  print('Query "flutter" -> ${flutterResults.map((j) => j.title).toList()}');

  // Query 2: matches company (case-insensitive)
  final dataCoResults = jobs.where((j) => j.matches('DATACO')).toList();
  assert(dataCoResults.length == 1 && dataCoResults.first.company == 'DataCo');
  print('Query "DATACO" -> ${dataCoResults.map((j) => j.title).toList()}');

  // Query 3: matches location, multiple results possible
  final capeTownResults = jobs.where((j) => j.matches('cape town')).toList();
  assert(capeTownResults.length == 1 && capeTownResults.first.location == 'Cape Town');
  print('Query "cape town" -> ${capeTownResults.map((j) => j.title).toList()}');

  print('All assertions passed.');
}