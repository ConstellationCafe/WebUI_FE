// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_config_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 채팅방의 메뉴 설정은 화면 이동 중 유지하고, 로그인·방 변경 때 다시 읽는다.
/// 활성화된 모듈에 한해서 별도 권한을 조회한다.

@ProviderFor(ModuleConfigNotifier)
final moduleConfigProvider = ModuleConfigNotifierProvider._();

/// 채팅방의 메뉴 설정은 화면 이동 중 유지하고, 로그인·방 변경 때 다시 읽는다.
/// 활성화된 모듈에 한해서 별도 권한을 조회한다.
final class ModuleConfigNotifierProvider
    extends
        $NotifierProvider<
          ModuleConfigNotifier,
          AsyncValue<ModuleAvailability>
        > {
  /// 채팅방의 메뉴 설정은 화면 이동 중 유지하고, 로그인·방 변경 때 다시 읽는다.
  /// 활성화된 모듈에 한해서 별도 권한을 조회한다.
  ModuleConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'moduleConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$moduleConfigNotifierHash();

  @$internal
  @override
  ModuleConfigNotifier create() => ModuleConfigNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<ModuleAvailability> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<ModuleAvailability>>(
        value,
      ),
    );
  }
}

String _$moduleConfigNotifierHash() =>
    r'219dcd0fa702e143399a19eecea890bcbb3a64ac';

/// 채팅방의 메뉴 설정은 화면 이동 중 유지하고, 로그인·방 변경 때 다시 읽는다.
/// 활성화된 모듈에 한해서 별도 권한을 조회한다.

abstract class _$ModuleConfigNotifier
    extends $Notifier<AsyncValue<ModuleAvailability>> {
  AsyncValue<ModuleAvailability> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<ModuleAvailability>,
              AsyncValue<ModuleAvailability>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ModuleAvailability>,
                AsyncValue<ModuleAvailability>
              >,
              AsyncValue<ModuleAvailability>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
