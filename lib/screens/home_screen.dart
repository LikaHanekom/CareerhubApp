import 'package:flutter/material.dart';
import '../models/job.dart';
import '../widgets/job_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<Job> _jobs = [
    Job(
      title: 'Flutter Developer',
      company: 'CareerHub',
      location: 'Pretoria',
      salary: 35000,
      employmentType: 'Full-time',
      isOpen: true,
      closingDate: DateTime(2026, 8, 1),
      description: 'Build mobile apps.',
    ),
    Job(
      title: 'Backend Intern',
      company: 'DataCo',
      location: 'Johannesburg',
      employmentType: 'Internship',
      isOpen: true,
    ),
    Job.closed(
      title: 'Product Designer',
      company: 'PixelWorks',
      location: 'Cape Town',
      employmentType: 'Full-time',
    ),
    Job.remote(
      title: 'DevOps Engineer',
      company: 'CloudNine',
      employmentType: 'Contract',
      salary: 42000,
    ),
  ];

  Widget _buildCard(BuildContext context, int index) {
    return JobCard(job: _jobs[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CareerHub')),
      body: Column(
        children: [
          // Filter chip row — fix for Question 1: SizedBox gives it bounded height
          SizedBox(
            height: 48,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Chip(label: Text('All')),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Chip(label: Text('Remote')),
                  ),
                  Chip(label: Text('Full-time')),
                ],
              ),
            ),
          ),
          // The Question 1 fix: Expanded gives ListView.builder a bounded height
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 600) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.87, // from Question 2
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _jobs.length,
                    itemBuilder: (context, index) => _buildCard(context, index),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _jobs.length,
                  itemBuilder: (context, index) => _buildCard(context, index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}