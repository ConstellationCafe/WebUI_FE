import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/profile/api/membership_api.dart';
import 'package:constellation_cafe/feature/profile/notifier/membership_notifier.dart';
import 'package:constellation_cafe/feature/profile/pages/view_point_log.dart';
import 'package:constellation_cafe/feature/profile/repository/point_repository.dart';
import 'package:constellation_cafe/feature/profile/widgets/input_membership_data.dart';
import 'package:constellation_cafe/feature/profile/widgets/save_membership_button.dart';
import 'package:constellation_cafe/shared/widgets/db_editor/EditorBar.dart';

import '../../support/fake_page_repository.dart';
import '../../support/screen.dart';
import '../../support/fake_translator.dart';
import 'support/membership_fixtures.dart';

Future<ProviderContainer> signedIn(FakeTranslator translator) async {
  final container = ProviderContainer(
    overrides: [
      membershipApiProvider.overrideWithValue(MembershipAPI(translator)),
    ],
  );
  addTearDown(container.dispose);
  final user = container.read(currentUserStateProvider.notifier);
  user.update(userId: '123', globalName: '별');
  await container.read(membershipProvider.notifier).initialize();
  return container;
}

Widget scoped(ProviderContainer container, Widget child) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      theme: CustomTheme.themeData,
      home: Scaffold(body: Center(child: child)),
    ),
  );
}

void main() {
  group('회원 정보 입력', () {
    testWidgets('바뀐 UID를 저장하고 결과를 스낵바로 알린다', (tester) async {
      final translator = FakeTranslator((path, args) async {
        if (path == createCardPath) return cardPayload();
        return {
          'payload': {'result': 'UID ${args[2]} 저장 완료'},
        };
      });
      final container = await signedIn(translator);
      await tester.pumpWidget(
        scoped(container, const InputMembershipData(width: 400)),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'UID1'),
        '222222222',
      );
      await tester.tap(find.text('저장'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('UID 222222222 저장 완료'), findsOneWidget);
      expect(translator.calls.last.$2, ['123', 's1', '222222222', '별']);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });

    testWidgets('저장 중에는 버튼을 비활성화해 중복 저장을 막는다', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SaveMembershipButton(isLoading: true, onPressed: null),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('저장'), findsNothing);
    });

    testWidgets('저장에 실패하면 오류 메시지를 보여준다', (tester) async {
      final translator = FakeTranslator((path, _) async {
        if (path == createCardPath) return cardPayload();
        throw StateError('봇 응답 없음');
      });
      final container = await signedIn(translator);
      await tester.pumpWidget(
        scoped(container, const InputMembershipData(width: 400)),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Guild'),
        '새 길드',
      );
      await tester.tap(find.text('저장'));
      await tester.pumpAndSettle();

      expect(find.textContaining('저장 중 오류 발생'), findsOneWidget);
      expect(find.text('저장'), findsOneWidget);
    });
  });

  testWidgets('포인트 내역 화면은 읽기 전용 표로 내역을 보여준다', (tester) async {
    final repository = FakePageRepository(pointResult());
    setScreenSize(tester, const Size(1200, 900));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [pointRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp(
          theme: CustomTheme.themeData,
          home: const Scaffold(body: ViewPointLog()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('변동 금액'), findsWidgets);
    expect(find.text('500'), findsOneWidget);
    expect(find.text('출석 보상'), findsOneWidget);
    expect(find.byType(EditorBar), findsNothing, reason: '읽기 전용이다');
  });
}
