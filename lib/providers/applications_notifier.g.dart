// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applications_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ApplicationsNotifier)
final applicationsProvider = ApplicationsNotifierProvider._();

final class ApplicationsNotifierProvider
    extends $AsyncNotifierProvider<ApplicationsNotifier, List<JobApplication>> {
  ApplicationsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'applicationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$applicationsNotifierHash();

  @$internal
  @override
  ApplicationsNotifier create() => ApplicationsNotifier();
}

String _$applicationsNotifierHash() =>
    r'9b6957b137ade8ac406ff0d3adaddc48cb621f9a';

abstract class _$ApplicationsNotifier
    extends $AsyncNotifier<List<JobApplication>> {
  FutureOr<List<JobApplication>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<JobApplication>>, List<JobApplication>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<JobApplication>>,
                List<JobApplication>
              >,
              AsyncValue<List<JobApplication>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
