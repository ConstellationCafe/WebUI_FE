// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guild_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentGuildStateNotifier)
final currentGuildStateProvider = CurrentGuildStateNotifierProvider._();

final class CurrentGuildStateNotifierProvider
    extends $NotifierProvider<CurrentGuildStateNotifier, CurrentGuildState> {
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
    r'a8974911615bcf0020b6a7a18243ee393861a660';

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
