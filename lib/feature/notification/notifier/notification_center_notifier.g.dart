// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_center_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 종 아이콘과 알림 패널의 상태를 소유한다.
///
/// 헤더가 보이는 동안(로그인한 채팅방 화면) 유지되며, 채팅방이 바뀌면 다시 만들어져
/// 새 채팅방의 알림을 구독한다. 실시간 연결이 서버 쪽에서 끝나면(토큰 만료 등)
/// 읽지 않은 개수를 REST로 먼저 다시 받아 토큰 갱신을 거친 뒤 지수 backoff로 재연결한다.

@ProviderFor(NotificationCenterNotifier)
final notificationCenterProvider = NotificationCenterNotifierProvider._();

/// 종 아이콘과 알림 패널의 상태를 소유한다.
///
/// 헤더가 보이는 동안(로그인한 채팅방 화면) 유지되며, 채팅방이 바뀌면 다시 만들어져
/// 새 채팅방의 알림을 구독한다. 실시간 연결이 서버 쪽에서 끝나면(토큰 만료 등)
/// 읽지 않은 개수를 REST로 먼저 다시 받아 토큰 갱신을 거친 뒤 지수 backoff로 재연결한다.
final class NotificationCenterNotifierProvider
    extends
        $NotifierProvider<NotificationCenterNotifier, NotificationCenterState> {
  /// 종 아이콘과 알림 패널의 상태를 소유한다.
  ///
  /// 헤더가 보이는 동안(로그인한 채팅방 화면) 유지되며, 채팅방이 바뀌면 다시 만들어져
  /// 새 채팅방의 알림을 구독한다. 실시간 연결이 서버 쪽에서 끝나면(토큰 만료 등)
  /// 읽지 않은 개수를 REST로 먼저 다시 받아 토큰 갱신을 거친 뒤 지수 backoff로 재연결한다.
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
    r'718924e9daf5e0302439fb8068ef0698ab870b3b';

/// 종 아이콘과 알림 패널의 상태를 소유한다.
///
/// 헤더가 보이는 동안(로그인한 채팅방 화면) 유지되며, 채팅방이 바뀌면 다시 만들어져
/// 새 채팅방의 알림을 구독한다. 실시간 연결이 서버 쪽에서 끝나면(토큰 만료 등)
/// 읽지 않은 개수를 REST로 먼저 다시 받아 토큰 갱신을 거친 뒤 지수 backoff로 재연결한다.

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
