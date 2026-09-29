// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guild_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 선택한 채팅방. 화면을 오가도 유지되도록 앱 수명 동안 유지한다.
/// (브라우저 새로고침은 앱을 다시 시작하므로 채팅방 선택 화면에서 다시 고른다.)

@ProviderFor(CurrentGuildStateNotifier)
final currentGuildStateProvider = CurrentGuildStateNotifierProvider._();

/// 선택한 채팅방. 화면을 오가도 유지되도록 앱 수명 동안 유지한다.
/// (브라우저 새로고침은 앱을 다시 시작하므로 채팅방 선택 화면에서 다시 고른다.)
final class CurrentGuildStateNotifierProvider
    extends $NotifierProvider<CurrentGuildStateNotifier, CurrentGuildState> {
  /// 선택한 채팅방. 화면을 오가도 유지되도록 앱 수명 동안 유지한다.
  /// (브라우저 새로고침은 앱을 다시 시작하므로 채팅방 선택 화면에서 다시 고른다.)
  CurrentGuildStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentGuildStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentGuildStateNotifierHash();

  @$internal
  @override
  CurrentGuildStateNotifier create() => CurrentGuildStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrentGuildState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrentGuildState>(value),
    );
  }
}

String _$currentGuildStateNotifierHash() =>
    r'b940da294c3dcd04230e935242a8dc6092d3b902';

/// 선택한 채팅방. 화면을 오가도 유지되도록 앱 수명 동안 유지한다.
/// (브라우저 새로고침은 앱을 다시 시작하므로 채팅방 선택 화면에서 다시 고른다.)

abstract class _$CurrentGuildStateNotifier
    extends $Notifier<CurrentGuildState> {
  CurrentGuildState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CurrentGuildState, CurrentGuildState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CurrentGuildState, CurrentGuildState>,
              CurrentGuildState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
