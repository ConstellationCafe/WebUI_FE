// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentUserStateNotifier)
final currentUserStateProvider = CurrentUserStateNotifierProvider._();

final class CurrentUserStateNotifierProvider
    extends $NotifierProvider<CurrentUserStateNotifier, CurrentUserState> {
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
    r'65f4fbe9cf5bedffb935ce90f3e832fadd248911';

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
