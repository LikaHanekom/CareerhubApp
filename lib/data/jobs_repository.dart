import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'job_dto.dart';
import '../models/job.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'jobs_repository.g.dart';

@riverpod
Dio dio(Ref ref) {
  const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:5011/api/v1/',
  );

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  dio.interceptors.add(
    LogInterceptor(requestBody: true, responseBody: true),
  );

  return dio;
}

@riverpod
JobsRepository jobsRepository(Ref ref) {
  return JobsRepository(ref.watch(dioProvider));
}

class JobsRepository {
  final Dio _dio;

  JobsRepository(this._dio);

  Future<List<Job>> getJobs() async {
    final response = await _dio.get('jobs');
    final body = response.data as Map<String, dynamic>;
    final data = body['data'] as List;
    return data
        .map((json) => JobDto.fromJson(json as Map<String, dynamic>))
        .map(Job.fromDto)
        .toList();
  }
}