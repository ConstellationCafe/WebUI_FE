// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_competition_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 대회 게시판 목록, 미리보기, 게시.

@ProviderFor(AdminCompetitionNotifier)
final adminCompetitionProvider = AdminCompetitionNotifierProvider._();

/// 대회 게시판 목록, 미리보기, 게시.
final class AdminCompetitionNotifierProvider
    extends $NotifierProvider<AdminCompetitionNotifier, AdminCompetitionState> {
  /// 대회 게시판 목록, 미리보기, 게시.
  AdminCompetitionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminCompetitionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminCompetitionNotifierHash();

  @$internal
  @override
  AdminCompetitionNotifier create() => AdminCompetitionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminCompetitionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminCompetitionState>(value),
    );
  }
}

String _$adminCompetitionNotifierHash() =>
    r'9e81f0e105b8409d5ee4e84cd7b633b9f3f4f153';

/// 대회 게시판 목록, 미리보기, 게시.

abstract class _$AdminCompetitionNotifier
    extends $Notifier<AdminCompetitionState> {
  AdminCompetitionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AdminCompetitionState, AdminCompetitionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminCompetitionState, AdminCompetitionState>,
              AdminCompetitionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
