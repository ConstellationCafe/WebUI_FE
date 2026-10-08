import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/auth/state/current_user_state.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/constants/penalty_strings.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/constants/penalty_tokens.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/data/dto/request/penalty_create_request.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/data/repository/penalty_repository_provider.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/domain/model/penalty_log.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/domain/model/penalty_page.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/notifier/penalty_permission_notifier.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/pages/admin_penalty_page.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/state/penalty_permission_state.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/widgets/penalty_award_dialog.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/widgets/penalty_cancel_dialog.dart';
import 'package:constellation_cafe/feature/modules/erp/penalty/widgets/penalty_log_tile.dart';
import 'package:constellation_cafe/shared/constants/date_time_picker_strings.dart';
import 'package:constellation_cafe/shared/domain/user/user_role.dart';

import 'package:constellation_cafe/test/support/feature/modules/erp/penalty/support/fake_penalty_repository.dart';

Widget adminApp(FakePenaltyRepository repository) => ProviderScope(
  overrides: [
    currentUserStateProvider.overrideWithValue(
      CurrentUserState.initial().copyWith(roles: [UserRole.admin]),
    ),
    penaltyRepositoryProvider.overrideWithValue(repository),
  ],
  child: MaterialApp(
    theme: CustomTheme.themeData,
    home: const Scaffold(body: AdminPenaltyPage()),
  ),
);

Widget memberApp(
  FakePenaltyRepository repository,
  PenaltyPermissionState permission,
) => ProviderScope(
  overrides: [
    currentUserStateProvider.overrideWithValue(
      CurrentUserState.initial().copyWith(roles: [UserRole.user]),
    ),
    penaltyPermissionProvider.overrideWithValue(permission),
    penaltyRepositoryProvider.overrideWithValue(repository),
  ],
  child: MaterialApp(
    theme: CustomTheme.themeData,
    home: const Scaffold(body: AdminPenaltyPage()),
  ),
);

void main() {
  group('벌점 관리 화면 권한', () {
    testWidgets('운영 매니저·운영 본부원은 관리자가 아니어도 벌점 이력을 본다', (tester) async {
      await tester.pumpWidget(
        memberApp(
          FakePenaltyRepository(),
          const PenaltyPermissionState(isInitialized: true, isManager: true),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text(PenaltyStrings.managerOnly), findsNothing);
      expect(find.text(PenaltyStrings.cancelPenalty), findsWidgets);
    });

    testWidgets('권한이 없으면 목록을 조회하지 않고 접근 안내를 보여준다', (tester) async {
      var historyCalls = 0;
      final repository = FakePenaltyRepository()
        ..historyHandler = (_, _, _) async {
          historyCalls++;
          return const PenaltyPage<PenaltyLog>(
            items: [],
            page: 1,
            size: 20,
            totalElements: 0,
            totalPages: 0,
            hasNext: false,
          );
        };
      await tester.pumpWidget(
        memberApp(
          repository,
          const PenaltyPermissionState(isInitialized: true),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text(PenaltyStrings.managerOnly), findsOneWidget);
      expect(historyCalls, 0);
    });

    testWidgets('권한을 확인하는 동안에는 안내 대신 로딩을 보여준다', (tester) async {
      await tester.pumpWidget(
        memberApp(
          FakePenaltyRepository(),
          const PenaltyPermissionState(isLoading: true),
        ),
      );
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text(PenaltyStrings.managerOnly), findsNothing);
    });
  });

  testWidgets('이력에서 대상의 현재 30일 누적 점수와 취소 기능을 본다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 750));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(adminApp(FakePenaltyRepository()));
    await tester.pumpAndSettle();
    expect(find.text(PenaltyStrings.cumulativeScore), findsWidgets);
    expect(find.text('2점'), findsWidgets);
    expect(find.text(PenaltyStrings.cancelPenalty), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('벌점 화면의 breadcrumb와 탭 크기, 순위 상세 중복 배지를 확인한다', (tester) async {
    await tester.pumpWidget(adminApp(FakePenaltyRepository()));
    await tester.pumpAndSettle();

    expect(find.text('ERP 메뉴'), findsOneWidget);
    final rankingTab = tester.widget<Tab>(
      find.widgetWithText(Tab, PenaltyStrings.ranking),
    );
    expect(rankingTab.height, PenaltyTokens.tabHeight);

    await tester.tap(find.text(PenaltyStrings.ranking));
    await tester.pumpAndSettle();
    await tester.tap(find.text('별').first);
    await tester.pumpAndSettle();
    expect(find.text(PenaltyStrings.currentScore), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('벌점 이력 카드와 탭의 시작선을 맞추고 취소 버튼 여백을 균일하게 둔다', (tester) async {
    await tester.pumpWidget(adminApp(FakePenaltyRepository()));
    await tester.pumpAndSettle();

    final tab = tester.getRect(find.byType(TabBar));
    final tile = tester.getRect(find.byType(PenaltyLogTile).first);
    final action = tester.getRect(
      find.widgetWithText(ElevatedButton, PenaltyStrings.cancelPenalty).first,
    );
    expect(tile.left, closeTo(tab.left, 1));
    expect(action.left - tile.left, closeTo(tile.bottom - action.bottom, 4));
  });

  testWidgets('탭 영역은 아래 TabBarView와 같은 가로 너비를 차지한다', (tester) async {
    for (final size in const [Size(1280, 800), Size(390, 750)]) {
      await tester.binding.setSurfaceSize(size);
      await tester.pumpWidget(adminApp(FakePenaltyRepository()));
      await tester.pumpAndSettle();

      final tabBar = tester.getRect(find.byType(TabBar));
      final tabBarView = tester.getRect(find.byType(TabBarView));
      expect(tabBar.left, closeTo(tabBarView.left, 0.5));
      expect(tabBar.width, closeTo(tabBarView.width, 0.5));
    }
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('대상자 우클릭 메뉴에서 닉네임과 Discord ID를 따로 복사한다', (tester) async {
    String? copied;
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') {
        copied = (call.arguments as Map)['text'] as String;
      }
      return null;
    });
    addTearDown(
      () => messenger.setMockMethodCallHandler(SystemChannels.platform, null),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: PenaltyLogTile(log: exampleLog())),
      ),
    );

    Future<void> rightClickIdentity() async {
      final gesture = await tester.startGesture(
        tester.getCenter(find.text('별 · 123')),
        kind: PointerDeviceKind.mouse,
        buttons: kSecondaryMouseButton,
      );
      await gesture.up();
      await tester.pumpAndSettle();
    }

    await rightClickIdentity();
    expect(find.text(PenaltyStrings.copyNickname), findsOneWidget);
    expect(find.text(PenaltyStrings.copyDiscordId), findsOneWidget);
    await tester.tap(find.text(PenaltyStrings.copyNickname));
    await tester.pumpAndSettle();
    expect(copied, '별');

    await rightClickIdentity();
    await tester.tap(find.text(PenaltyStrings.copyDiscordId));
    await tester.pumpAndSettle();
    expect(copied, '123');
  });

  testWidgets('이력 로딩, 오류와 빈 결과를 구분한다', (tester) async {
    final pending = Completer<PenaltyPage<PenaltyLog>>();
    final repository = FakePenaltyRepository()
      ..historyHandler = (_, __, ___) => pending.future;
    await tester.pumpWidget(adminApp(repository));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsWidgets);
    pending.completeError(StateError('network error'));
    await tester.pumpAndSettle();
    expect(find.text(PenaltyStrings.loadFailed), findsOneWidget);
    repository.historyHandler = (_, __, ___) async => const PenaltyPage(
      items: [],
      page: 1,
      size: 20,
      totalElements: 0,
      totalPages: 0,
      hasNext: false,
    );
    await tester.tap(find.text(PenaltyStrings.retry));
    await tester.pumpAndSettle();
    expect(find.text(PenaltyStrings.noHistory), findsOneWidget);
  });

  testWidgets('큰 글자에서도 벌점 입력을 구분하고 제출을 중복하지 않는다', (tester) async {
    final pending = Completer<bool>();
    int count = 0;
    PenaltyCreateRequest? submitted;
    await tester.pumpWidget(
      MaterialApp(
        theme: CustomTheme.themeData,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(1.4)),
          child: child!,
        ),
        home: Scaffold(
          body: PenaltyAwardDialog(
            onSubmit: (request) {
              count++;
              submitted = request;
              return pending.future;
            },
          ),
        ),
      ),
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, PenaltyStrings.targetId),
      '123',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, PenaltyStrings.channelId),
      '999',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, PenaltyStrings.reason),
      '도배',
    );
    await tester.ensureVisible(find.text(PenaltyStrings.award).last);
    await tester.tap(find.text(PenaltyStrings.award).last);
    await tester.pump();
    expect(count, 1);
    expect(submitted!.score, 1);
    expect(
      find.widgetWithText(ElevatedButton, PenaltyStrings.award),
      findsNothing,
    );
    expect(tester.takeException(), isNull);
    pending.complete(false);
    await tester.pumpAndSettle();
    expect(find.text(PenaltyStrings.submitFailed), findsOneWidget);
  });

  testWidgets('발생 시각은 날짜·시간 선택기로 골라 함께 보낸다', (tester) async {
    final now = DateTime(2026, 10, 3, 20, 35);
    final submitted = <PenaltyCreateRequest>[];
    await tester.pumpWidget(
      MaterialApp(
        theme: CustomTheme.themeData,
        home: Scaffold(
          body: PenaltyAwardDialog(
            clock: () => now,
            onSubmit: (request) async {
              submitted.add(request);
              return false;
            },
          ),
        ),
      ),
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, PenaltyStrings.targetId),
      '123',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, PenaltyStrings.channelId),
      '999',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, PenaltyStrings.reason),
      '도배',
    );

    final date = find.text(DateTimePickerStrings.selectDate);
    await tester.ensureVisible(date);
    await tester.tap(date);
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.text('2026-10-03'), findsOneWidget);
    expect(find.text('20:35'), findsOneWidget);

    await tester.ensureVisible(find.text(PenaltyStrings.award).last);
    await tester.tap(find.text(PenaltyStrings.award).last);
    await tester.pumpAndSettle();
    expect(submitted.single.occurredAt, now);
  });

  testWidgets('취소 사유 입력과 감사 기록 안내를 표시한다', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PenaltyCancelDialog(
            log: exampleLog(),
            onSubmit: (_) async => false,
          ),
        ),
      ),
    );
    expect(find.text(PenaltyStrings.cancellationNotice), findsOneWidget);
    await tester.tap(find.text(PenaltyStrings.cancelPenalty).last);
    await tester.pump();
    expect(find.text(PenaltyStrings.invalidReason), findsOneWidget);
  });
  testWidgets('벌점 사유와 누적 점수는 메타데이터보다 눈에 띄게 표시한다', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: CustomTheme.themeData,
        home: Scaffold(
          body: PenaltyLogTile(log: exampleLog(), cumulativeScore: 2),
        ),
      ),
    );

    final reason = tester.widget<Text>(find.text('도배'));
    final metadata = tester.widget<Text>(find.text('부여자 900'));
    expect(reason.style?.fontSize, PenaltyTokens.reasonTextSize);
    expect(metadata.style?.fontSize, PenaltyTokens.metadataTextSize);
    expect(find.text('벌점 1점 · 누적벌점 2점'), findsOneWidget);
  });
}
