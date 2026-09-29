import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/auth/state/current_user_state.dart';
import 'package:constellation_cafe/feature/modules/chatbot/category/chatbot_category.dart';
import 'package:constellation_cafe/feature/modules/chatbot/learning/data/repository/learning_repository.dart';
import 'package:constellation_cafe/feature/modules/chatbot/learning/domain/entity/learning_entity.dart';
import 'package:constellation_cafe/feature/modules/chatbot/learning/pages/learning_list.dart';
import 'package:constellation_cafe/shared/domain/user/user_role.dart';
import 'package:constellation_cafe/shared/widgets/db_editor/editor_usage.dart';

import '../../../support/fake_page_repository.dart';
import '../../../support/screen.dart';
import 'support/chatbot_fixtures.dart';

void main() {
  group('가르치기 목록', () {
    late FakePageRepository<LearningEntity> repository;

    setUp(() {
      // 튜토리얼 오버레이는 이미 본 것으로 처리한다.
      SharedPreferences.setMockInitialValues({EditorUsage.key: true});
      repository = FakePageRepository(learningResult());
    });

    Future<void> pumpList(WidgetTester tester, List<String> roles) async {
      setScreenSize(tester, const Size(1200, 900));
      final user = CurrentUserState.initial().copyWith(roles: roles);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentUserStateProvider.overrideWithValue(user),
            learningRepositoryProvider.overrideWithValue(repository),
          ],
          child: MaterialApp(
            theme: CustomTheme.themeData,
            home: const Scaffold(body: LearningList()),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('조회한 학습 데이터를 표로 보여준다', (tester) async {
      await pumpList(tester, [UserRole.admin]);

      expect(repository.requestedPages, [1]);
      expect(find.text('안녕'), findsOneWidget);
      expect(find.text('반가워'), findsOneWidget);
      expect(find.text('데이터가 없습니다.'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('관리자에게만 가르친 사람 컬럼을 보여준다', (tester) async {
      await pumpList(tester, [UserRole.admin]);
      expect(find.text('discordId'), findsWidgets);
      expect(find.text('900'), findsOneWidget);
    });

    testWidgets('일반 회원에게는 가르친 사람을 숨긴다', (tester) async {
      await pumpList(tester, [UserRole.user]);
      expect(find.text('discordId'), findsNothing);
      expect(find.text('900'), findsNothing);
      expect(find.text('안녕'), findsOneWidget);
    });
  });

  testWidgets('빗자루 메뉴는 네 가지 기능으로 이동할 수 있다', (tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: ChatBotCategory()),
        ),
        GoRoute(
          path: '/music',
          builder: (_, _) => const Scaffold(body: Text('music page')),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(child: MaterialApp.router(routerConfig: router)),
    );
    await tester.pumpAndSettle();

    for (final menu in ['가르치기', '메뉴추천', '노래추천', '놀이추천']) {
      expect(find.text(menu), findsOneWidget);
    }

    await tester.tap(find.text('노래추천'));
    await tester.pumpAndSettle();
    expect(find.text('music page'), findsOneWidget);
  });
}
