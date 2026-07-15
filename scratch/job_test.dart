import 'package:careerhub/models/job.dart';

void main() {
  final job1 = Job(
    id: '1',
    title: 'Flutter Developer',
    company: 'CareerHub',
    location: 'Pretoria',
    salary: 35000,
    employmentType: 'Full-time',
    isOpen: true,
    closingDate: DateTime(2026, 8, 1),
    description: 'Build mobile apps.',
  );

  final job2 = Job(
    id: '2',
    title: 'Backend Intern',
    company: 'DataCo',
    location: 'Johannesburg',
    employmentType: 'Internship',
    isOpen: true,
  );

  final job3 = Job.closed(
    id: '3',
    title: 'Product Designer',
    company: 'PixelWorks',
    location: 'Cape Town',
    employmentType: 'Full-time',
  );

  final job4 = Job.remote(
    id: '4',
    title: 'DevOps Engineer',
    company: 'CloudNine',
    employmentType: 'Contract',
    salary: 42000,
  );

  for (final job in [job1, job2, job3, job4]) {
    print(job);
    print('  canApply: ${job.canApply}, displaySalary: ${job.displaySalary}');
  }

  final job5 = job1.copyWith(isOpen: false);
  print(job5);
  print('  Unchanged fields preserved: ${job5.title == job1.title}');

  final job6 = job1.copyWith();
  print('  copyWith() with no args equals original: ${job6.toString() == job1.toString()}');
}