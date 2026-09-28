// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_penalty_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminPenaltyNotifier)
final adminPenaltyProvider = AdminPenaltyNotifierProvider._();

final class AdminPenaltyNotifierProvider
    extends $NotifierProvider<AdminPenaltyNotifier, AdminPenaltyState> {
  AdminPenaltyNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminPenaltyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminPenaltyNotifierHash();

  @$internal
  @override
  AdminPenaltyNotifier create() => AdminPenaltyNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminPenaltyState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminPenaltyState>(value),
    );
  }
}

String _$adminPenaltyNotifierHash() =>
    r'29b921791cbc09c3d2e8c04cffec2f4a62cab414';

abstract class _$AdminPenaltyNotifier extends $Notifier<AdminPenaltyState> {
  AdminPenaltyState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AdminPenaltyState, AdminPenaltyState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminPenaltyState, AdminPenaltyState>,
              AdminPenaltyState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
