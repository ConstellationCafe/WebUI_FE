import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/modules/competition/constants/competition_strings.dart';
import 'package:constellation_cafe/feature/modules/competition/data/repository/competition_repository_provider.dart';
import 'package:constellation_cafe/feature/modules/competition/pages/admin_competition_page.dart';
import 'package:constellation_cafe/test/support/feature/modules/competition/support/fake_competition_repository.dart';

void main() {
  testWidgets('필수 입력이 비어 있으면 공지를 게시하지 않고 입력 오류를 보여준다', (tester) async {
    final repository = FakeCompetitionRepository();
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [competitionRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp(
          theme: CustomTheme.themeData,
          home: Scaffold(body: AdminCompetitionPage(clock: () => DateTime(2026, 10, 1, 9))),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text(CompetitionStrings.submit));
    await tester.tap(find.text(CompetitionStrings.submit));
    await tester.pumpAndSettle();

    expect(find.text(CompetitionStrings.fieldRequired), findsNWidgets(3));
    expect(find.text(CompetitionStrings.dateRequired), findsOneWidget);
    expect(repository.postCalls, 0);
    expect(tester.takeException(), isNull);
  });
}
