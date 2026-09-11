// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academy_permission_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AcademyPermissionNotifier)
final academyPermissionProvider = AcademyPermissionNotifierProvider._();

final class AcademyPermissionNotifierProvider
    extends
        $NotifierProvider<AcademyPermissionNotifier, AcademyPermissionState> {
  AcademyPermissionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'academyPermissionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$academyPermissionNotifierHash();

  @$internal
  @override
  AcademyPermissionNotifier create() => AcademyPermissionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AcademyPermissionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AcademyPermissionState>(value),
    );
  }
}

String _$academyPermissionNotifierHash() =>
    r'f76da0a9b311ff3ae946ed76c7506a0401d09fe8';

abstract class _$AcademyPermissionNotifier
    extends $Notifier<AcademyPermissionState> {
  AcademyPermissionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AcademyPermissionState, AcademyPermissionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AcademyPermissionState, AcademyPermissionState>,
              AcademyPermissionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
