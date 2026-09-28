import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/notification/constants/notification_strings.dart';
import 'package:constellation_cafe/feature/notification/constants/notification_tokens.dart';
import 'package:constellation_cafe/feature/notification/domain/model/app_notification.dart';
import 'package:constellation_cafe/feature/notification/domain/type/notification_category.dart';
import 'package:constellation_cafe/feature/notification/notifier/notification_center_notifier.dart';
import 'package:constellation_cafe/feature/notification/widgets/notification_bell.dart';
import 'package:constellation_cafe/feature/notification/widgets/notification_panel.dart';
import 'package:constellation_cafe/feature/notification/widgets/notification_tile.dart';

import 'support/fake_notification_repository.dart';

const _dot = ValueKey('notification-unread-dot');
const _bell = ValueKey('notification-bell');

Widget _app(FakeNotificationRepository repository, {double textScale = 1}) {
  return ProviderScope(
    overrides: [notificationRepositoryProvider.overrideWithValue(repository)],
    child: MaterialApp(
      theme: CustomTheme.themeData,
      builder: (context, child) {
        final scaler = TextScaler.linear(textScale);
        final data = MediaQuery.of(context).copyWith(textScaler: scaler);
        return MediaQuery(data: data, child: child!);
      },
      home: const Scaffold(
        body: Align(alignment: Alignment.topRight, child: NotificationBell()),
      ),
    ),
  );
}

void main() {
  testWidgets('읽지 않은 알림이 있으면 종 아이콘에 빨간 점과 개수 안내를 표시한다', (tester) async {
    final repository = FakeNotificationRepository()
      ..unreadSummary = summary(3, latestId: 12);

    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    expect(find.byKey(_dot), findsOneWidget);
    expect(find.byTooltip(NotificationStrings.unreadCount(3)), findsOneWidget);
  });

  testWidgets('읽지 않은 알림이 없으면 빨간 점을 표시하지 않는다', (tester) async {
    await tester.pumpWidget(_app(FakeNotificationRepository()));
    await tester.pumpAndSettle();

    expect(find.byKey(_dot), findsNothing);
    expect(find.byTooltip(NotificationStrings.bellTooltip), findsOneWidget);
  });

  testWidgets('종 아이콘을 눌러 알림을 보면 빨간 점이 사라진다', (tester) async {
    final repository = FakeNotificationRepository()
      ..unreadSummary = summary(1, latestId: 12)
      ..firstPage = [appNotification(12)];

    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();
    expect(find.byKey(_dot), findsOneWidget);

    await tester.tap(find.byKey(_bell));
    await tester.pumpAndSettle();

    expect(find.text('공지 12'), findsOneWidget);
    expect(find.text(NotificationStrings.panelTitle), findsOneWidget);
    expect(repository.markReadCalls, [12]);
    expect(find.byKey(_dot), findsNothing);
  });

  testWidgets('받은 알림이 없으면 빈 상태 문구를 보여준다', (tester) async {
    await tester.pumpWidget(_app(FakeNotificationRepository()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(_bell));
    await tester.pumpAndSettle();

    expect(find.text(NotificationStrings.empty), findsOneWidget);
  });

  testWidgets('목록을 불러오지 못하면 다시 시도할 수 있다', (tester) async {
    final repository = FakeNotificationRepository()
      ..listError = StateError('down');
    await tester.pumpWidget(_app(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(_bell));
    await tester.pumpAndSettle();
    expect(find.text(NotificationStrings.loadFailed), findsOneWidget);

    repository.listError = null;
    repository.firstPage = [appNotification(7)];
    await tester.tap(find.text(NotificationStrings.retry));
    await tester.pumpAndSettle();

    expect(find.text('공지 7'), findsOneWidget);
    expect(find.text(NotificationStrings.loadFailed), findsNothing);
  });

  testWidgets('작은 화면과 큰 글자에서도 패널이 깨지지 않는다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final repository = FakeNotificationRepository()
      ..unreadSummary = summary(2, latestId: 12)
      ..firstPage = [appNotification(12), appNotification(11)];

    await tester.pumpWidget(_app(repository, textScale: 1.5));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(_bell));
    await tester.pumpAndSettle();

    final layoutIssue = tester.takeException();
    print(
      'notification panel geometry: '
      'panel=${tester.getRect(find.byType(NotificationPanel))}, '
      'bell=${tester.getRect(find.byKey(_bell))}, '
      'layoutIssue=$layoutIssue',
    );
    expect(layoutIssue, isNull);
    expect(find.text('공지 11'), findsOneWidget);
    final panel = tester.getRect(find.byType(NotificationPanel));
    final bell = tester.getRect(find.byKey(_bell));
    expect(
      panel.left,
      greaterThanOrEqualTo(NotificationTokens.panelScreenMargin),
    );
    expect(
      panel.right,
      lessThanOrEqualTo(320 - NotificationTokens.panelScreenMargin),
    );
    expect(panel.top, greaterThan(bell.bottom));
  });

  testWidgets('본문이 비어 있으면 안내 문구를 표시한다', (tester) async {
    final notification = AppNotification(
      id: 1,
      category: NotificationCategory.system,
      title: '제목',
      body: '  ',
      link: null,
      createdAt: DateTime.utc(2026, 9, 28),
      read: true,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationTile(
            notification: notification,
            now: DateTime.utc(2026, 9, 28, 0, 5),
          ),
        ),
      ),
    );

    expect(find.text(NotificationStrings.noBody), findsOneWidget);
    expect(find.text(NotificationStrings.minutesAgo(5)), findsOneWidget);
  });
}
