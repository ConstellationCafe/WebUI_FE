// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_point_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminPointNotifier)
final adminPointProvider = AdminPointNotifierProvider._();

final class AdminPointNotifierProvider
    extends $NotifierProvider<AdminPointNotifier, AdminPointState> {
  AdminPointNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminPointProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminPointNotifierHash();

  @$internal
  @override
  AdminPointNotifier create() => AdminPointNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminPointState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminPointState>(value),
    );
  }
}

String _$adminPointNotifierHash() =>
    r'8a14b9583754462546c1d83104c5dc1409d7e2b5';

abstract class _$AdminPointNotifier extends $Notifier<AdminPointState> {
  AdminPointState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AdminPointState, AdminPointState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminPointState, AdminPointState>,
              AdminPointState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
