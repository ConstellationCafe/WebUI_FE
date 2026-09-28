// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_center_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationCenterNotifier)
final notificationCenterProvider = NotificationCenterNotifierProvider._();

final class NotificationCenterNotifierProvider
    extends
        $NotifierProvider<NotificationCenterNotifier, NotificationCenterState> {
  NotificationCenterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationCenterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationCenterNotifierHash();

  @$internal
  @override
  NotificationCenterNotifier create() => NotificationCenterNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationCenterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationCenterState>(value),
    );
  }
}

String _$notificationCenterNotifierHash() =>
    r'0bcd57bf87b1da5c5fa7febc29a377229e5c8d9f';

abstract class _$NotificationCenterNotifier
    extends $Notifier<NotificationCenterState> {
  NotificationCenterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<NotificationCenterState, NotificationCenterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NotificationCenterState, NotificationCenterState>,
              NotificationCenterState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
