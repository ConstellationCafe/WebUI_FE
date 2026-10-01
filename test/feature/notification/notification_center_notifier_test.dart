import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/notification/domain/model/notification_realtime_event.dart';
import 'package:constellation_cafe/feature/notification/notifier/notification_center_notifier.dart';

import 'support/fake_notification_repository.dart';

void main() {
  late FakeNotificationRepository repository;
  late ProviderContainer container;

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  setUp(() async {
    repository = FakeNotificationRepository()
      ..unreadSummary = summary(2, latestId: 12, lastReadId: 10);
    container = ProviderContainer(
      overrides: [notificationRepositoryProvider.overrideWithValue(repository)],
    );
    container.listen(notificationCenterProvider, (_, _) {});
    await settle();
  });

  tearDown(() => container.dispose());

  NotificationCenterNotifier notifier() {
    return container.read(notificationCenterProvider.notifier);
  }

  test('처음 연결하면 읽지 않은 개수를 받아 빨간 점 상태를 만든다', () {
    final state = container.read(notificationCenterProvider);
    expect(state.unreadCount, 2);
    expect(state.latestId, 12);
    expect(repository.watchCount, 1);
  });

  test('ready 이벤트로 끊긴 동안의 읽지 않은 상태를 다시 맞춘다', () async {
    repository.emit(
      NotificationRealtimeReady(summary(5, latestId: 20, lastReadId: 15)),
    );
    await settle();

    final state = container.read(notificationCenterProvider);
    expect(state.unreadCount, 5);
    expect(state.isRealtimeConnected, isTrue);
  });

  test('새 알림을 받으면 개수가 늘고, 같은 알림이 다시 와도 한 번만 센다', () async {
    repository.emit(NotificationRealtimeReceived(appNotification(13)));
    repository.emit(NotificationRealtimeReceived(appNotification(13)));
    await settle();

    final state = container.read(notificationCenterProvider);
    expect(state.unreadCount, 3);
    expect(state.latestId, 13);
  });

  test('패널을 열면 최신 알림까지 읽음 처리해 빨간 점이 사라진다', () async {
    repository.firstPage = [appNotification(12), appNotification(11)];
    repository.lastReadId = 10;

    await notifier().openPanel();

    final state = container.read(notificationCenterProvider);
    expect(repository.markReadCalls, [12]);
    expect(state.unreadCount, 0);
    expect(state.items.map((item) => item.id), [12, 11]);
    expect(state.items.first.read, isFalse, reason: '이번에 새로 본 알림은 강조한다');
    expect(state.hasLoaded, isTrue);
  });

  test('패널이 열린 채로 새 알림이 오면 목록에 추가하고 바로 읽음 처리한다', () async {
    repository.firstPage = [appNotification(12)];
    await notifier().openPanel();

    repository.emit(NotificationRealtimeReceived(appNotification(13)));
    await settle();

    final state = container.read(notificationCenterProvider);
    expect(state.items.first.id, 13);
    expect(repository.markReadCalls.last, 13);
    expect(state.unreadCount, 0);
  });

  test('패널을 닫은 뒤 온 알림은 빨간 점으로만 표시한다', () async {
    repository.firstPage = [appNotification(12)];
    await notifier().openPanel();
    notifier().closePanel();

    repository.emit(NotificationRealtimeReceived(appNotification(14)));
    await settle();

    final state = container.read(notificationCenterProvider);
    expect(state.unreadCount, 1);
    expect(repository.markReadCalls, [12]);
  });

  test('목록 조회에 실패하면 오류 상태를 두고 다시 시도할 수 있다', () async {
    repository.listError = StateError('down');
    await notifier().openPanel();
    expect(container.read(notificationCenterProvider).hasError, isTrue);

    repository.listError = null;
    repository.firstPage = [appNotification(12)];
    await notifier().loadFirstPage();

    final state = container.read(notificationCenterProvider);
    expect(state.hasError, isFalse);
    expect(state.items.single.id, 12);
  });

  test('더 보기는 마지막 알림 ID를 커서로 이어서 불러온다', () async {
    repository.firstPage = [appNotification(12)];
    await notifier().openPanel();

    await notifier().loadMore();

    final state = container.read(notificationCenterProvider);
    expect(repository.pageRequests, [null, 12]);
    expect(state.items.map((item) => item.id), [12, 11]);
    expect(state.isLoadingMore, isFalse);
  });

  test('실시간을 지원하지 않는 플랫폼에서는 연결하지 않는다', () async {
    final unsupported = FakeNotificationRepository()..realtime = false;
    final other = ProviderContainer(
      overrides: [
        notificationRepositoryProvider.overrideWithValue(unsupported),
      ],
    );
    addTearDown(other.dispose);
    other.listen(notificationCenterProvider, (_, _) {});
    await settle();

    expect(unsupported.watchCount, 0);
  });
}
