import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'job_dto.dart';
import '../models/job.dart';
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
  return JobsRepository(ref.watch(dioProvider));
}

class JobsRepository {
  final Dio _dio;

  JobsRepository(this._dio);

  Future<ApiResult<List<Job>>> getJobs() async {
    try {
      final response = await _dio.get('jobs');
      final body = response.data as Map<String, dynamic>;
      final (:jobs, :totalCount) = _parseJobsResponse(body);
      return Success(jobs);
    } on DioException catch (e) {
      return Failure(_messageForDioException(e), statusCode: e.response?.statusCode);
    } catch (e) {
      return Failure('Something went wrong. Please try again.');
    }
  }
  //private helper
  ({List<Job> jobs, int totalCount}) _parseJobsResponse(Map<String, dynamic> body) {
    final data = body['data'] as List;
    final jobs = data
        .map((json) => JobDto.fromJson(json as Map<String, dynamic>))
        .map(Job.fromDto)
        .toList();
    final totalCount = body['totalCount'] as int;
    return (jobs: jobs, totalCount: totalCount);
  }

  String _messageForDioException(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => 'The server took too long to respond. Please try again.',
      DioExceptionType.connectionError => 'No internet connection. Please check your network.',
      DioExceptionType.badResponse => 'The server returned an error (${e.response?.statusCode}).',
      _ => 'Something went wrong while fetching jobs.',
    };
  }
}