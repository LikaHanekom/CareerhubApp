// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_jobs_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SavedJobsNotifier)
final savedJobsProvider = SavedJobsNotifierProvider._();

final class SavedJobsNotifierProvider
    extends $NotifierProvider<SavedJobsNotifier, Set<String>> {
  SavedJobsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedJobsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedJobsNotifierHash();

  @$internal
  @override
  SavedJobsNotifier create() => SavedJobsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$savedJobsNotifierHash() => r'7f51c31b25c5e841e1afbb2e9e766784732cdcea';

abstract class _$SavedJobsNotifier extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
