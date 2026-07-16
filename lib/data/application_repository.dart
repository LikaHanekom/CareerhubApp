import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'api_result.dart';
import '../models/job_application.dart';
import '../models/job_application_dto.dart';
import '../models/job_application_isar.dart';

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
      final response = await _dio.get('/api/v1/applications');

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> dataList = response.data as List<dynamic>;

        // Parse raw response data into DTOs and maps to Domain models
        final domainList = dataList.map((json) {
          final dto = JobApplicationDto.fromJson(json as Map<String, dynamic>);
          return JobApplication.fromDto(dto);
        }).toList();

        // Convert domain entities to Isar entities
        final isarEntities = domainList
            .map((domain) => JobApplicationIsar.fromDomain(domain))
            .toList();

        // Atomically replace the entire cache table inside a write transaction
        _isar.writeTxnSync(() {
          _isar.jobApplicationIsars.clearSync();
          _isar.jobApplicationIsars.putAllSync(isarEntities);
        });

        return ApiResult.success(domainList);
      }

      return ApiResult.failure(
        'Failed to fetch applications',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return ApiResult.failure(
        e.message ?? 'An unexpected network error occurred.',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResult.failure('An unexpected error occurred: $e');
    }
  }
}
