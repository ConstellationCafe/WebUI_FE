// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academy_permission_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 여러 아카데미 화면에서 공유하며, 방 변경·로그아웃 때 명시적으로 비운다.

@ProviderFor(AcademyPermissionNotifier)
final academyPermissionProvider = AcademyPermissionNotifierProvider._();

/// 여러 아카데미 화면에서 공유하며, 방 변경·로그아웃 때 명시적으로 비운다.
final class AcademyPermissionNotifierProvider
    extends
        $NotifierProvider<AcademyPermissionNotifier, AcademyPermissionState> {
  /// 여러 아카데미 화면에서 공유하며, 방 변경·로그아웃 때 명시적으로 비운다.
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
    r'82916e8da85dcf37f0d06f8d5876fe943b9f7635';

/// 여러 아카데미 화면에서 공유하며, 방 변경·로그아웃 때 명시적으로 비운다.

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
