import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/notification/constants/notification_strings.dart';
import 'package:constellation_cafe/feature/notification/data/repository/admin_notification_repository.dart';
import 'package:constellation_cafe/feature/notification/domain/model/notification_draft.dart';
import 'package:constellation_cafe/feature/notification/domain/model/notification_publish_failure.dart';
import 'package:constellation_cafe/feature/notification/domain/model/sent_notification.dart';
import 'package:constellation_cafe/feature/notification/domain/type/notification_category.dart';
import 'package:constellation_cafe/feature/notification/domain/type/notification_target_type.dart';
import 'package:constellation_cafe/feature/notification/notifier/admin_notification_notifier.dart';
import 'package:constellation_cafe/feature/notification/pages/admin_notification_page.dart';
import 'package:constellation_cafe/feature/notification/widgets/admin_notification_form.dart';

class _FakeAdminRepository extends Fake implements AdminNotificationRepository {
  Object? historyError;
  List<SentNotification> history = [];

  @override
  Future<SentNotificationPage> getHistory({required int page}) async {
    final error = historyError;
    if (error != null) throw error;
    return SentNotificationPage(items: history, page: page, totalPages: 1);
  }
}

SentNotification _sent(int id) {
  return SentNotification(
    id: id,
    targetType: NotificationTargetType.guild,
    targetDiscordId: null,
    category: NotificationCategory.announcement,
    title: '발행한 공지 $id',
    body: '본문',
    link: null,
    source: 'ADMIN',
    sourceRef: '42',
    createdAt: DateTime.utc(2026, 9, 28),
  );
}

Widget _formApp(
  Future<NotificationPublishFailure?> Function(NotificationDraft) submit,
) {
  return MaterialApp(
    theme: CustomTheme.themeData,
    home: Scaffold(
      body: SingleChildScrollView(
        child: AdminNotificationForm(isSubmitting: false, submit: submit),
      ),
    ),
  );
}

Future<void> _fillRequired(WidgetTester tester) async {
  await tester.enterText(
    find.widgetWithText(TextFormField, NotificationStrings.titleLabel),
    '점검 안내',
  );
  await tester.enterText(
    find.widgetWithText(TextFormField, NotificationStrings.bodyLabel),
    '오늘 밤 점검합니다.',
  );
}

Future<void> _tapPublish(WidgetTester tester) async {
  final button = find.text(NotificationStrings.publish);
  await tester.ensureVisible(button);
  await tester.tap(button);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('제목과 내용이 비어 있으면 발행하지 않고 안내한다', (tester) async {
    var calls = 0;
    await tester.pumpWidget(
      _formApp((_) async {
        calls++;
        return null;
      }),
    );

    await _tapPublish(tester);

    expect(find.text(NotificationStrings.titleRequired), findsOneWidget);
    expect(find.text(NotificationStrings.bodyRequired), findsOneWidget);
    expect(calls, 0);
  });

  testWidgets('앱 외부 링크는 입력할 수 없다', (tester) async {
    var calls = 0;
    await tester.pumpWidget(
      _formApp((_) async {
        calls++;
        return null;
      }),
    );
    await _fillRequired(tester);
    await tester.enterText(
      find.widgetWithText(TextFormField, NotificationStrings.linkLabel),
      'https://evil.example',
    );

    await _tapPublish(tester);

    expect(find.text(NotificationStrings.linkInvalid), findsOneWidget);
    expect(calls, 0);
  });

  testWidgets('결과를 알 수 없는 실패 뒤 다시 발행하면 같은 요청 ID를 쓴다', (tester) async {
    final drafts = <NotificationDraft>[];
    final results = <NotificationPublishFailure?>[
      NotificationPublishFailure.unknown,
      null,
    ];
    await tester.pumpWidget(
      _formApp((draft) async {
        drafts.add(draft);
        return results.removeAt(0);
      }),
    );
    await _fillRequired(tester);

    await _tapPublish(tester);
    expect(find.text(NotificationStrings.publishUnknown), findsOneWidget);

    await _tapPublish(tester);

    expect(drafts, hasLength(2));
    expect(drafts[1].requestId, drafts[0].requestId);
    expect(drafts[0].targetType, NotificationTargetType.guild);
    expect(drafts[0].targetDiscordId, isNull);
    expect(find.text(NotificationStrings.published), findsOneWidget);
  });

  testWidgets('내용을 바꾸면 새 요청 ID로 발행한다', (tester) async {
    final drafts = <NotificationDraft>[];
    await tester.pumpWidget(
      _formApp((draft) async {
        drafts.add(draft);
        return NotificationPublishFailure.unknown;
      }),
    );
    await _fillRequired(tester);
    await _tapPublish(tester);

    await tester.enterText(
      find.widgetWithText(TextFormField, NotificationStrings.titleLabel),
      '바뀐 제목',
    );
    await _tapPublish(tester);

    expect(drafts[1].requestId, isNot(drafts[0].requestId));
  });

  testWidgets('특정 회원 대상은 숫자 Discord ID가 필요하다', (tester) async {
    var calls = 0;
    await tester.pumpWidget(
      _formApp((_) async {
        calls++;
        return NotificationPublishFailure.notMember;
      }),
    );
    await tester.tap(find.text(NotificationStrings.targetGuild));
    await tester.pumpAndSettle();
    await tester.tap(find.text(NotificationStrings.targetUser).last);
    await tester.pumpAndSettle();
    await _fillRequired(tester);

    await _tapPublish(tester);
    expect(find.text(NotificationStrings.discordIdInvalid), findsOneWidget);
    expect(calls, 0);

    await tester.enterText(
      find.widgetWithText(TextFormField, NotificationStrings.targetDiscordId),
      '123',
    );
    await _tapPublish(tester);

    expect(calls, 1);
    expect(find.text(NotificationStrings.notMember), findsOneWidget);
  });

  testWidgets('발행 이력이 없으면 빈 상태를, 실패하면 다시 시도를 보여준다', (tester) async {
    final repository = _FakeAdminRepository()..historyError = StateError('x');
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          adminNotificationRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(home: Scaffold(body: AdminNotificationPage())),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text(NotificationStrings.historyFailed), findsOneWidget);

    repository.historyError = null;
    // 좁은 화면에서는 이력이 작성 폼 아래에 있으므로 버튼이 보이도록 스크롤한다.
    await tester.ensureVisible(find.text(NotificationStrings.retry));
    await tester.pumpAndSettle();
    await tester.tap(find.text(NotificationStrings.retry));
    await tester.pumpAndSettle();
    expect(find.text(NotificationStrings.noHistory), findsOneWidget);
  });

  testWidgets('작은 화면과 큰 글자에서도 발행 화면을 사용할 수 있다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final repository = _FakeAdminRepository()..history = [_sent(1), _sent(2)];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          adminNotificationRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp(
          theme: CustomTheme.themeData,
          builder: (context, child) {
            final scaler = TextScaler.linear(1.5);
            final data = MediaQuery.of(context).copyWith(textScaler: scaler);
            return MediaQuery(data: data, child: child!);
          },
          home: const Scaffold(body: AdminNotificationPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    await tester.scrollUntilVisible(
      find.text('발행한 공지 2'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('발행한 공지 2'), findsOneWidget);
  });
}
