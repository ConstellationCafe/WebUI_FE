// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academy_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
