import 'package:flutter_test/flutter_test.dart';
import 'package:careerhub/models/job.dart';

void main() {
  group('Job equality', () {
    test('two Jobs with identical fields are equal and share hashCode', () {
      final job1 = Job(
        id: '1',
        title: 'Flutter Developer',
        company: 'CareerHub',
        location: 'Pretoria',
        employmentType: 'Full-time',
        isOpen: true,
      );
      final job2 = Job(
        id: '1',
        title: 'Flutter Developer',
        company: 'CareerHub',
        location: 'Pretoria',
        employmentType: 'Full-time',
        isOpen: true,
      );

      expect(job1, equals(job2));
      expect(job1.hashCode, equals(job2.hashCode));
    });

    test('two Jobs differing in one field are not equal', () {
      final job1 = Job(
        id: '1',
        title: 'Flutter Developer',
        company: 'CareerHub',
        location: 'Pretoria',
        employmentType: 'Full-time',
        isOpen: true,
      );
      final job2 = job1.copyWith(title: 'Backend Developer');

      expect(job1, isNot(equals(job2)));
    });

    test('a Set of identical Jobs collapses to one entry', () {
      final jobSet = <Job>{};
      for (var i = 0; i < 5; i++) {
        jobSet.add(
          Job(
            id: '1',
            title: 'Flutter Developer',
            company: 'CareerHub',
            location: 'Pretoria',
            employmentType: 'Full-time',
            isOpen: true,
          ),
        );
      }

      expect(jobSet.length, 1);
    });
  });
}