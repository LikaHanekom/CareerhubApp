import 'package:flutter/material.dart';
import 'models/job.dart';
import 'widgets/job_card.dart';

void main() => runApp(const CareerHubApp());

class CareerHubApp extends StatelessWidget {
  const CareerHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareerHub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final jobs = [
      Job(
        title: 'Flutter Developer',
        company: 'CareerHub',
        location: 'Pretoria',
        salary: 35000,
        employmentType: 'Full-time',
        isOpen: false,
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

    return Scaffold(
      appBar: AppBar(title: const Text('CareerHub')),
      body: ListView(
        children: jobs.map((job) => JobCard(job: job)).toList(),
      ),
    );
  }
}