// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GlobalStateNotifier)
final globalStateProvider = GlobalStateNotifierProvider._();

final class GlobalStateNotifierProvider
    extends $NotifierProvider<GlobalStateNotifier, GlobalState> {
  GlobalStateNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'globalStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$globalStateNotifierHash();

  @$internal
  @override
  GlobalStateNotifier create() => GlobalStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GlobalState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GlobalState>(value),
    );
  }
}

String _$globalStateNotifierHash() =>
    r'297a047b1aed799c3f4f712041efae3de760563a';

abstract class _$GlobalStateNotifier extends $Notifier<GlobalState> {
  GlobalState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GlobalState, GlobalState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<GlobalState, GlobalState>, GlobalState, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
