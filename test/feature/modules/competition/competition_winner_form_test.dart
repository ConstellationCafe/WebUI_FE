import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/modules/competition/constants/competition_strings.dart';
import 'package:constellation_cafe/feature/modules/competition/domain/model/competition_winner.dart';
import 'package:constellation_cafe/feature/modules/competition/widgets/competition_winner_form.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/domain/version/game_version_type.dart';

Future<List<CompetitionWinnerDraft>> _pump(WidgetTester tester) async {
  final drafts = <CompetitionWinnerDraft>[];
  await tester.pumpWidget(
    MaterialApp(
      theme: CustomTheme.themeData,
      home: Scaffold(
        body: SingleChildScrollView(
          child: CompetitionWinnerForm(
            isSubmitting: false,
            clock: () => DateTime(2026, 10, 3),
            submit: (draft) async {
              drafts.add(draft);
              return null;
            },
          ),
        ),
      ),
    ),
  );
  return drafts;
}

void main() {
  testWidgets('게임 버전은 드롭다운이며 S2만 고를 수 있다', (tester) async {
    await _pump(tester);

    final dropdown = tester.widget<DropdownButton<GameVersionType>>(
      find.byType(DropdownButton<GameVersionType>),
    );
    expect(dropdown.items!.map((item) => item.value), [GameVersionType.s2]);
    expect(dropdown.value, GameVersionType.s2);
    expect(find.text('S2'), findsWidgets);
  });

  testWidgets('선택한 게임 버전으로 칭호를 부여한다', (tester) async {
    final drafts = await _pump(tester);

    await tester.enterText(
      find.widgetWithText(
        TextFormField,
        CompetitionStrings.winnerCompetitionLabel,
      ),
      '별자리 컵',
    );
    await tester.enterText(
      find.widgetWithText(
        TextFormField,
        CompetitionStrings.winnerDiscordIdLabel,
      ),
      '123',
    );
    await tester.tap(find.text(CompetitionStrings.selectDate));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text(CompetitionStrings.grant));
    await tester.tap(find.text(CompetitionStrings.grant));
    await tester.pumpAndSettle();

    expect(drafts.single.version, GameVersionType.s2);
    expect(drafts.single.competitionName, '별자리 컵');
    expect(drafts.single.acquisition, DateTime(2026, 10, 3));
  });
}
