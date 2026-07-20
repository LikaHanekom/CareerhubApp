import 'package:dio/dio.dart';
import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'job_dto.dart';
import 'job_cache.dart';
import '../models/job.dart';
import '../core/isar_provider.dart';
import 'api_result.dart';

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
  return JobsRepository(
    dio: ref.watch(dioProvider),
    isar: ref.watch(isarProvider),
  );
}

class JobsRepository {
  final Dio _dio;
  final Isar _isar;

  const JobsRepository({required Dio dio, required Isar isar})
      : _dio = dio,
        _isar = isar;

  Future<List<Job>> getCachedJobs() async {
    final cached = await _isar.jobCaches.where().findAll();
    return cached.map(_toDomain).toList();
  }

  Future<ApiResult<List<Job>>> getJobs() async {
    try {
      final response = await _dio.get('jobs');
      final body = response.data as Map<String, dynamic>;
      final (:jobs, :totalCount) = _parseJobsResponse(body);

      await _isar.writeTxn(() async {
        await _isar.jobCaches.clear();
        await _isar.jobCaches.putAll(jobs.map(_toCache).toList());
      });

      return Success(jobs);
    } on DioException catch (e) {
      return switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.connectionError =>
            NetworkFailure('No internet connection. Please check your network.'),
        DioExceptionType.badResponse =>
            ServerFailure(
              'The server returned an error.',
              e.response?.statusCode ?? 0,
            ),
        _ => UnknownFailure('Something went wrong while fetching jobs.'),
      };
    } catch (e) {
      return UnknownFailure('Something went wrong. Please try again.');
    }
  }

  ({List<Job> jobs, int totalCount}) _parseJobsResponse(Map<String, dynamic> body) {
    final data = body['data'] as List;
    final jobs = data
        .map((json) => JobDto.fromJson(json as Map<String, dynamic>))
        .map(Job.fromDto)
        .toList();
    final totalCount = body['totalCount'] as int;
    return (jobs: jobs, totalCount: totalCount);
  }

  Job _toDomain(JobCache cache) => cache.toDomain();

  JobCache _toCache(Job job) => JobCache.fromDomain(job);
}
