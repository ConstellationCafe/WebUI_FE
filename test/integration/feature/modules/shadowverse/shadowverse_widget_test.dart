import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/auth/state/current_user_state.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/data/api/shadowverse_api.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/pages/friendly_match.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/widgets/friendly_match_usage.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/widgets/view_friendly_match.dart';

import 'package:constellation_cafe/test/support/fake_translator.dart';

Future<FakeTranslator> pumpFriendlyMatch(
  WidgetTester tester, {
  Size size = const Size(1400, 900),
  TranslatorHandler? handler,
}) async {
  SharedPreferences.setMockInitialValues({FriendlyMatchUsage.key: true});
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  final translator = FakeTranslator(handler);
  final user = CurrentUserState.initial().copyWith(globalName: '별');
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentUserStateProvider.overrideWithValue(user),
        shadowverseApiProvider.overrideWithValue(ShadowverseAPI(translator)),
      ],
      child: MaterialApp(
        theme: CustomTheme.themeData,
        home: const Scaffold(body: FriendlyMatch()),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return translator;
}

Future<Map<String, dynamic>> sent(String _, List<dynamic> _) async {
  return {
    'payload': {'result': '전송 완료'},
  };
}

Finder preview(String text) {
  return find.descendant(
    of: find.byType(ViewFriendlyMatch),
    matching: find.text(text),
  );
}

void main() {
  testWidgets('기본 선택값과 보낸 사람을 미리보기에 보여준다', (tester) async {
    await pumpFriendlyMatch(tester);

    expect(preview('별님의 친선'), findsOneWidget);
    expect(preview('s1'), findsOneWidget);
    expect(preview('타임슬립 로테이션'), findsOneWidget);
    expect(preview('bo1'), findsOneWidget);
    expect(preview('Message'), findsNothing, reason: '메시지가 없으면 숨긴다');
    expect(tester.takeException(), isNull);
  });

  testWidgets('입력한 방 번호와 메시지를 미리보기에 반영한다', (tester) async {
    await pumpFriendlyMatch(tester);

    await tester.enterText(find.widgetWithText(TextFormField, 'Room'), '12345');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Message'),
      '같이 해요',
    );
    await tester.pump();

    expect(preview('12345'), findsOneWidget);
    expect(preview('같이 해요'), findsOneWidget);
  });

  testWidgets('버전을 바꾸면 해당 버전 선택지로 초기화하고 입력을 비운다', (tester) async {
    await pumpFriendlyMatch(tester);
    await tester.enterText(find.widgetWithText(TextFormField, 'Room'), '12345');

    await tester.tap(find.text('s1').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('s2').last);
    await tester.pumpAndSettle();

    expect(preview('s2'), findsOneWidget);
    expect(preview('로테이션'), findsOneWidget);
    expect(preview('12345'), findsNothing);
  });

  testWidgets('전송하면 선택한 값으로 요청하고 결과를 안내한다', (tester) async {
    final translator = await pumpFriendlyMatch(tester, handler: sent);
    await tester.enterText(find.widgetWithText(TextFormField, 'Room'), '777');

    await tester.tap(find.text('전송'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('전송 완료'), findsOneWidget);
    final args = translator.calls.single.$2;
    expect(args[1], ['s1', '타임슬립 로테이션', 'bo1', '777', '']);
    expect(args[3], '별');
  });

  testWidgets('전송에 실패하면 실패 사유를 안내하고 다시 누를 수 있다', (tester) async {
    await pumpFriendlyMatch(
      tester,
      handler: (_, _) async => throw StateError('라우터 응답 없음'),
    );

    await tester.tap(find.text('전송'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.textContaining('전송 실패'), findsOneWidget);
    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, '전송'),
    );
    expect(button.onPressed, isNotNull);
  });

  testWidgets('모바일 폭에서는 미리보기와 입력을 세로로 쌓는다', (tester) async {
    await pumpFriendlyMatch(tester, size: const Size(390, 1400));

    final view = tester.getTopLeft(find.byType(ViewFriendlyMatch));
    final input = tester.getTopLeft(find.widgetWithText(TextFormField, 'Room'));
    expect(input.dy, greaterThan(view.dy));
    expect(tester.takeException(), isNull);
  });
}
