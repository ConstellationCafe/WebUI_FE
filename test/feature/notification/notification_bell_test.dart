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

// 실제 헤더처럼 종 오른쪽에 프로필 아이콘 자리가 있는 경우를 재현한다.
const _profileSlotWidth = 56.0;

/// `setSurfaceSize`는 MediaQuery 크기를 바꾸지 않으므로 view 크기로 화면을 맞춘다.
void _useScreen(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

void _expectPanelInsideScreen(WidgetTester tester, double screenWidth) {
  final panel = tester.getRect(find.byType(NotificationPanel));
  final bell = tester.getRect(find.byKey(_bell));
  const margin = NotificationTokens.panelScreenMargin;
  expect(panel.left, greaterThanOrEqualTo(margin));
  expect(panel.right, lessThanOrEqualTo(screenWidth - margin));
  expect(panel.top, greaterThan(bell.bottom));
}

Widget _app(
  FakeNotificationRepository repository, {
  double textScale = 1,
  double trailingWidth = 0,
}) {
  return ProviderScope(
    overrides: [notificationRepositoryProvider.overrideWithValue(repository)],
    child: MaterialApp(
      theme: CustomTheme.themeData,
      builder: (context, child) {
        final scaler = TextScaler.linear(textScale);
        final data = MediaQuery.of(context).copyWith(textScaler: scaler);
        return MediaQuery(data: data, child: child!);
      },
      home: Scaffold(
        body: Align(
          alignment: Alignment.topRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const NotificationBell(),
              SizedBox(width: trailingWidth),
            ],
          ),
        ),
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
    _useScreen(tester, const Size(320, 568));
    final repository = FakeNotificationRepository()
      ..unreadSummary = summary(2, latestId: 12)
      ..firstPage = [appNotification(12), appNotification(11)];

    await tester.pumpWidget(_app(repository, textScale: 1.5));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(_bell));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('공지 11'), findsOneWidget);
    _expectPanelInsideScreen(tester, 320);
  });

  testWidgets('종 오른쪽에 프로필 아이콘이 있어도 패널이 화면 양옆 여백을 지킨다', (tester) async {
    _useScreen(tester, const Size(360, 640));
    final repository = FakeNotificationRepository()
      ..firstPage = [appNotification(12)];

    await tester.pumpWidget(_app(repository, trailingWidth: _profileSlotWidth));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(_bell));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('공지 12'), findsOneWidget);
    _expectPanelInsideScreen(tester, 360);
  });

  testWidgets('넓은 화면에서는 패널 오른쪽 끝을 종 아이콘 쪽에 맞춘다', (tester) async {
    _useScreen(tester, const Size(1280, 800));
    final repository = FakeNotificationRepository()
      ..firstPage = [appNotification(12)];

    await tester.pumpWidget(_app(repository, trailingWidth: _profileSlotWidth));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(_bell));
    await tester.pumpAndSettle();

    final panel = tester.getRect(find.byType(NotificationPanel));
    final bell = tester.getRect(find.byKey(_bell));
    expect(panel.width, NotificationTokens.panelWidth);
    expect(
      panel.right,
      moreOrLessEquals(bell.right - NotificationTokens.panelScreenMargin),
    );
    _expectPanelInsideScreen(tester, 1280);
  });

  testWidgets('구분선과 화면 끝 사이 거리만큼 구분선 아래·화면 오른쪽에서 띄운다', (tester) async {
    _useScreen(tester, const Size(1280, 800));
    final dividerKey = GlobalKey();
    const header = 64.0;
    const sidePadding = 24.0;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notificationRepositoryProvider.overrideWithValue(
            FakeNotificationRepository(),
          ),
        ],
        child: MaterialApp(
          theme: CustomTheme.themeData,
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: sidePadding),
              child: Column(
                children: [
                  SizedBox(
                    height: header,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NotificationBell(dividerKey: dividerKey),
                          const SizedBox(width: _profileSlotWidth),
                        ],
                      ),
                    ),
                  ),
                  Divider(key: dividerKey, thickness: 1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(_bell));
    await tester.pumpAndSettle();

    final panel = tester.getRect(find.byType(NotificationPanel));
    final divider = tester.getRect(find.byKey(dividerKey));
    const screenWidth = 1280.0;
    final gap = screenWidth - divider.right;
    expect(gap, moreOrLessEquals(sidePadding));
    expect(panel.right, moreOrLessEquals(screenWidth - gap));
    expect(panel.top, moreOrLessEquals(divider.center.dy + gap));
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
