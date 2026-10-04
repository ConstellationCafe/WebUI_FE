// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penalty_permission_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 벌점 관리 메뉴·화면 표시 여부. 대회 권한처럼 화면을 오가도 유지하고,
/// 로그인 사용자 정보를 불러오거나 채팅방을 바꿀 때 다시 조회한다(ModuleConfigNotifier).

@ProviderFor(PenaltyPermissionNotifier)
final penaltyPermissionProvider = PenaltyPermissionNotifierProvider._();

/// 벌점 관리 메뉴·화면 표시 여부. 대회 권한처럼 화면을 오가도 유지하고,
/// 로그인 사용자 정보를 불러오거나 채팅방을 바꿀 때 다시 조회한다(ModuleConfigNotifier).
final class PenaltyPermissionNotifierProvider
    extends
        $NotifierProvider<PenaltyPermissionNotifier, PenaltyPermissionState> {
  /// 벌점 관리 메뉴·화면 표시 여부. 대회 권한처럼 화면을 오가도 유지하고,
  /// 로그인 사용자 정보를 불러오거나 채팅방을 바꿀 때 다시 조회한다(ModuleConfigNotifier).
  PenaltyPermissionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'penaltyPermissionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$penaltyPermissionNotifierHash();

  @$internal
  @override
  PenaltyPermissionNotifier create() => PenaltyPermissionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PenaltyPermissionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PenaltyPermissionState>(value),
    );
  }
}

String _$penaltyPermissionNotifierHash() =>
    r'ffa1e1851b08933b5d105603d831a63b6b4fe92d';

/// 벌점 관리 메뉴·화면 표시 여부. 대회 권한처럼 화면을 오가도 유지하고,
/// 로그인 사용자 정보를 불러오거나 채팅방을 바꿀 때 다시 조회한다(ModuleConfigNotifier).

abstract class _$PenaltyPermissionNotifier
    extends $Notifier<PenaltyPermissionState> {
  PenaltyPermissionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<PenaltyPermissionState, PenaltyPermissionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PenaltyPermissionState, PenaltyPermissionState>,
              PenaltyPermissionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
