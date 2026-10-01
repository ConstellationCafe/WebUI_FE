// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_notification_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 관리자 알림 발행과 발행 이력.

@ProviderFor(AdminNotificationNotifier)
final adminNotificationProvider = AdminNotificationNotifierProvider._();

/// 관리자 알림 발행과 발행 이력.
final class AdminNotificationNotifierProvider
    extends
        $NotifierProvider<AdminNotificationNotifier, AdminNotificationState> {
  /// 관리자 알림 발행과 발행 이력.
  AdminNotificationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminNotificationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminNotificationNotifierHash();

  @$internal
  @override
  AdminNotificationNotifier create() => AdminNotificationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminNotificationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminNotificationState>(value),
    );
  }
}

String _$adminNotificationNotifierHash() =>
    r'db7cfe19aef1c0fb368fc4624c2ec18120e90511';

/// 관리자 알림 발행과 발행 이력.

abstract class _$AdminNotificationNotifier
    extends $Notifier<AdminNotificationState> {
  AdminNotificationState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AdminNotificationState, AdminNotificationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminNotificationState, AdminNotificationState>,
              AdminNotificationState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
