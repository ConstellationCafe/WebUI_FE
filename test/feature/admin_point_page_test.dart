import 'package:constellation_cafe/feature/admin/point/pages/admin_point_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows mock members, balance, and point history', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AdminPointPage())),
    );

    expect(find.text('포인트 관리'), findsOneWidget);
    expect(find.text('별빛고래'), findsWidgets);
    expect(find.text('18,200 P'), findsOneWidget);
    expect(find.text('친선전 참여 보상'), findsOneWidget);
  });

  testWidgets('searches by Discord ID and filters the member list', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AdminPointPage())),
    );

    await tester.enterText(find.byType(TextField).first, '926184730519284736');
    await tester.pumpAndSettle();

    expect(find.text('모카라떼'), findsWidgets);
    expect(find.text('별빛고래'), findsOneWidget);
    expect(find.text('1명'), findsOneWidget);
  });

  testWidgets('adds a mock deposit and records its description', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AdminPointPage())),
    );

    await tester.tap(find.text('입금').first);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), '800');
    await tester.enterText(find.byType(TextField).at(1), '목업 지급 테스트');
    await tester.tap(find.text('입금하기'));
    await tester.pumpAndSettle();

    expect(find.text('19,000 P'), findsOneWidget);
    expect(find.text('목업 지급 테스트'), findsOneWidget);
  });
}
