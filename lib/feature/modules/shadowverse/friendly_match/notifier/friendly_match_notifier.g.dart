// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendly_match_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FriendlyMatchNotifier)
final friendlyMatchProvider = FriendlyMatchNotifierProvider._();

final class FriendlyMatchNotifierProvider
    extends $NotifierProvider<FriendlyMatchNotifier, FriendlyMatchState> {
  FriendlyMatchNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'friendlyMatchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$friendlyMatchNotifierHash();

  @$internal
  @override
  FriendlyMatchNotifier create() => FriendlyMatchNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FriendlyMatchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FriendlyMatchState>(value),
    );
  }
}

String _$friendlyMatchNotifierHash() =>
    r'1b4d89682bc6ed749a8540c0cdadd44c358fc22d';

abstract class _$FriendlyMatchNotifier extends $Notifier<FriendlyMatchState> {
  FriendlyMatchState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<FriendlyMatchState, FriendlyMatchState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FriendlyMatchState, FriendlyMatchState>,
              FriendlyMatchState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
