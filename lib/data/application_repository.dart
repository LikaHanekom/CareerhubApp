import 'package:dio/dio.dart';
import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../main.dart';
import '../models/job_application.dart';
import 'api_result.dart';
import 'dio_provider.dart';
import 'job_application_dto.dart';
import 'job_application_isar.dart';

part 'application_repository.g.dart';

/// Reads dioProvider and isarProvider from the provider graph rather than
/// constructing either itself.
@riverpod
ApplicationsRepository applicationsRepository(Ref ref) {
  return ApplicationsRepository(
    dio: ref.watch(dioProvider),
    isar: ref.watch(isarProvider),
  );
}

class ApplicationsRepository {
  final Dio _dio;
  final Isar _isar;

  ApplicationsRepository({
    required Dio dio,
    required Isar isar,
  })  : _dio = dio,
        _isar = isar;

  /// Reads cached applications directly from Isar with zero network calls
  List<JobApplication> getCachedApplications() {
    final isarApplications = _isar.jobApplicationIsars.where().findAllSync();
    return isarApplications.map((isarModel) => isarModel.toDomain()).toList();
  }

  /// Fetches live data, updates the local cache atomically, and returns an ApiResult
  Future<ApiResult<List<JobApplication>>> fetchAndCacheApplications() async {
    try {
      // Replace with your actual CareerHub API route endpoint
      final response = await _dio.get(
        '/applications',
        queryParameters: {'applicantId': 'a1111111-1111-1111-1111-111111111111'}, // placeholder until auth exists
      );

      if (response.statusCode == 200 && response.data is List) {
        final dataList = response.data as List<dynamic>;

        // Parse raw response data into DTOs and map to domain models
        final domainList = dataList.map((json) {
          final dto = JobApplicationDto.fromJson(json as Map<String, dynamic>);
          return JobApplication.fromDto(dto);
        }).toList();

        // Convert domain entities to Isar entities
        final isarEntities = domainList
            .map((domain) => JobApplicationIsar.fromDomain(domain))
            .toList();

        // Atomically replace the entire cache table inside a write transaction
        await _isar.writeTxn(() async {
          await _isar.jobApplicationIsars.clear();
          await _isar.jobApplicationIsars.putAll(isarEntities);
        });

        return Success(domainList);
      }

      return ServerFailure(
        'Failed to fetch applications',
        response.statusCode ?? 0,
      );
    } on DioException catch (e) {
      return switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.connectionError =>
            NetworkFailure('No internet connection. Please check your network.'),
        DioExceptionType.badResponse => ServerFailure(
          'The server returned an error.',
          e.response?.statusCode ?? 0,
        ),
        _ => UnknownFailure('Something went wrong while fetching applications.'),
      };
    } catch (e) {
      return UnknownFailure('An unexpected error occurred: $e');
    }
  }
}
