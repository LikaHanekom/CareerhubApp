import 'package:dio/dio.dart';
import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../main.dart';
import '../models/job.dart';
import '../models/job_application.dart';
import 'api_result.dart';
import 'dio_provider.dart';
import 'job_application_dto.dart';
import 'job_application_isar.dart';
import '../core/isar_provider.dart';

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
        queryParameters: {'applicantId': 'b2222222-2222-2222-2222-222222222222'}, // placeholder until auth exists
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

  Future<ApiResult<void>> applyToJob({
    required Job job,
    required String fullName,
    required String email,
    String? phone,
    required int yearsOfExperience,
    required String coverLetter,
    String? linkedInUrl,
    required bool availableImmediately,
    required int noticePeriodWeeks,
  }) async {
    try {
      final response = await _dio.post(
        '/applications/apply',
        data: {
          'jobListingId': job.id,
          // Same placeholder used in fetchAndCacheApplications — swap
          // both out together once real auth exists.
          'applicantId': 'a1111111-1111-1111-1111-111111111111',
          'fullName': fullName,
          'email': email,
          'phone': phone,
          'yearsOfExperience': yearsOfExperience,
          'coverLetter': coverLetter,
          'linkedInUrl': linkedInUrl,
          'availableImmediately': availableImmediately,
          'noticePeriodWeeks': noticePeriodWeeks,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Success(null);
      }
      return ServerFailure('Failed to submit application', response.statusCode ?? 0);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final serverMessage = _extractErrorMessage(e.response?.data);

      // Map your controller's specific exceptions to readable messages.
      if (statusCode == 400) {
        return ServerFailure(
          serverMessage ?? 'This listing is no longer accepting applications.',
          400,
        );
      }
      if (statusCode == 409) {
        return ServerFailure(
          serverMessage ?? 'You have already applied for this job.',
          409,
        );
      }
      if (statusCode == 429) {
        return const ServerFailure(
          'Too many attempts. Please wait a moment and try again.',
          429,
        );
      }

      return switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.connectionError =>
            NetworkFailure('No internet connection. Please check your network.'),
        DioExceptionType.badResponse => ServerFailure(
          serverMessage ?? 'The server returned an error.',
          statusCode ?? 0,
        ),
        _ => UnknownFailure(serverMessage ?? 'Something went wrong while applying.'),
      };
    } catch (e) {
      return UnknownFailure('An unexpected error occurred: $e');
    }
  }

  /// Best-effort extraction of a human-readable message from an error
  /// response body — your controller sometimes returns a plain string
  /// (BadRequest(ex.Message)) and sometimes an ASP.NET ModelState
  /// validation dictionary (the automatic 400 from [ApiController]).
  String? _extractErrorMessage(dynamic data) {
    if (data is String) return data;
    if (data is Map) {
      if (data['title'] is String) return data['title'] as String;
      final errors = data['errors'];
      if (errors is Map) {
        for (final value in errors.values) {
          if (value is List && value.isNotEmpty) {
            return value.first.toString();
          }
        }
      }
    }
    return null;
  }
}
