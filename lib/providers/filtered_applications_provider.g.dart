// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_applications_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(filteredApplications)
final filteredApplicationsProvider = FilteredApplicationsProvider._();

final class FilteredApplicationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<JobApplication>>,
          AsyncValue<List<JobApplication>>,
          AsyncValue<List<JobApplication>>
        >
    with $Provider<AsyncValue<List<JobApplication>>> {
  FilteredApplicationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredApplicationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredApplicationsHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<List<JobApplication>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<List<JobApplication>> create(Ref ref) {
    return filteredApplications(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<JobApplication>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<JobApplication>>>(
        value,
      ),
    );
  }
}

String _$filteredApplicationsHash() =>
    r'b34e012bd54ec603e13196f548f332e81dea19f6';
