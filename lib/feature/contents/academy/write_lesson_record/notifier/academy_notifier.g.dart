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

String _$academyNotifierHash() => r'ab47bdfb90bfc6ddde8c9b42979737ce1e68e21b';

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
