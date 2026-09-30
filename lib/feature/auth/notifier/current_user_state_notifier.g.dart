// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 로그인한 사용자는 화면을 오가도 다시 조회하지 않도록 앱 수명 동안 유지한다.
/// (브라우저 새로고침은 앱을 다시 시작하므로 로그인 확인 후 다시 불러온다.)

@ProviderFor(CurrentUserStateNotifier)
final currentUserStateProvider = CurrentUserStateNotifierProvider._();

/// 로그인한 사용자는 화면을 오가도 다시 조회하지 않도록 앱 수명 동안 유지한다.
/// (브라우저 새로고침은 앱을 다시 시작하므로 로그인 확인 후 다시 불러온다.)
final class CurrentUserStateNotifierProvider
    extends $NotifierProvider<CurrentUserStateNotifier, CurrentUserState> {
  /// 로그인한 사용자는 화면을 오가도 다시 조회하지 않도록 앱 수명 동안 유지한다.
  /// (브라우저 새로고침은 앱을 다시 시작하므로 로그인 확인 후 다시 불러온다.)
  CurrentUserStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserStateNotifierHash();

  @$internal
  @override
  CurrentUserStateNotifier create() => CurrentUserStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrentUserState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrentUserState>(value),
    );
  }
}

String _$currentUserStateNotifierHash() =>
    r'eb4c12aa11671ea5f4ba0ef4010db8521c101fed';

/// 로그인한 사용자는 화면을 오가도 다시 조회하지 않도록 앱 수명 동안 유지한다.
/// (브라우저 새로고침은 앱을 다시 시작하므로 로그인 확인 후 다시 불러온다.)

abstract class _$CurrentUserStateNotifier extends $Notifier<CurrentUserState> {
  CurrentUserState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CurrentUserState, CurrentUserState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CurrentUserState, CurrentUserState>,
              CurrentUserState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
