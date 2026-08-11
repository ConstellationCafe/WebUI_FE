// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academy_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(academyApi)
final academyApiProvider = AcademyApiProvider._();

final class AcademyApiProvider
    extends $FunctionalProvider<AcademyApi, AcademyApi, AcademyApi>
    with $Provider<AcademyApi> {
  AcademyApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'academyApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$academyApiHash();

  @$internal
  @override
  $ProviderElement<AcademyApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AcademyApi create(Ref ref) {
    return academyApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AcademyApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AcademyApi>(value),
    );
  }
}

String _$academyApiHash() => r'b292d8db414f88ad3f6de89f1d1c955b3eeabbaa';

@ProviderFor(AcademyNotifier)
final academyProvider = AcademyNotifierProvider._();

final class AcademyNotifierProvider
    extends $NotifierProvider<AcademyNotifier, AcademyFormState> {
  AcademyNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'academyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$academyNotifierHash();

  @$internal
  @override
  AcademyNotifier create() => AcademyNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AcademyFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AcademyFormState>(value),
    );
  }
}

String _$academyNotifierHash() => r'a5baa8607040f6b420ed2a6b881bfd321f0674cd';

abstract class _$AcademyNotifier extends $Notifier<AcademyFormState> {
  AcademyFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AcademyFormState, AcademyFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AcademyFormState, AcademyFormState>,
              AcademyFormState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
