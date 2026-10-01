// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competition_permission_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 대회 메뉴 표시 여부. 아카데미 권한처럼 화면을 오가도 유지하고,
/// 로그인 사용자 정보를 불러오거나 채팅방을 바꿀 때 다시 조회한다(CurrentUserStateNotifier).

@ProviderFor(CompetitionPermissionNotifier)
final competitionPermissionProvider = CompetitionPermissionNotifierProvider._();

/// 대회 메뉴 표시 여부. 아카데미 권한처럼 화면을 오가도 유지하고,
/// 로그인 사용자 정보를 불러오거나 채팅방을 바꿀 때 다시 조회한다(CurrentUserStateNotifier).
final class CompetitionPermissionNotifierProvider
    extends
        $NotifierProvider<
          CompetitionPermissionNotifier,
          CompetitionPermissionState
        > {
  /// 대회 메뉴 표시 여부. 아카데미 권한처럼 화면을 오가도 유지하고,
  /// 로그인 사용자 정보를 불러오거나 채팅방을 바꿀 때 다시 조회한다(CurrentUserStateNotifier).
  CompetitionPermissionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'competitionPermissionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$competitionPermissionNotifierHash();

  @$internal
  @override
  CompetitionPermissionNotifier create() => CompetitionPermissionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompetitionPermissionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompetitionPermissionState>(value),
    );
  }
}

String _$competitionPermissionNotifierHash() =>
    r'1a5ca721271b6927476643fb32f26cd80b9f58f9';

/// 대회 메뉴 표시 여부. 아카데미 권한처럼 화면을 오가도 유지하고,
/// 로그인 사용자 정보를 불러오거나 채팅방을 바꿀 때 다시 조회한다(CurrentUserStateNotifier).

abstract class _$CompetitionPermissionNotifier
    extends $Notifier<CompetitionPermissionState> {
  CompetitionPermissionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<CompetitionPermissionState, CompetitionPermissionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                CompetitionPermissionState,
                CompetitionPermissionState
              >,
              CompetitionPermissionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
