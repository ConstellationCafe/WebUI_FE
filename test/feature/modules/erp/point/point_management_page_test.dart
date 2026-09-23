import 'package:constellation_cafe/feature/modules/erp/point/pages/point_management_page.dart';
import 'package:constellation_cafe/feature/modules/erp/point/state/point_management_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_point_management_repository.dart';

void main() {
  testWidgets('selects a member and displays balance and point history', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pointManagementRepositoryProvider.overrideWithValue(
            FakePointManagementRepository(),
          ),
        ],
        child: const MaterialApp(home: Scaffold(body: PointManagementPage())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Mina'), findsOneWidget);
    await tester.tap(find.text('Mina'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('point-current-balance')), findsOneWidget);
    expect(find.text('1,250 P'), findsNWidgets(2));
    expect(find.text('monthly reward'), findsOneWidget);
    expect(find.text('+250 P'), findsOneWidget);
  });

  testWidgets('submits a point deposit with the entered description', (
    tester,
  ) async {
    final repository = FakePointManagementRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pointManagementRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(home: Scaffold(body: PointManagementPage())),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mina'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('point-deposit-button')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('point-adjustment-amount')),
      '75',
    );
    await tester.enterText(
      find.byKey(const Key('point-adjustment-description')),
      'event bonus',
    );
    await tester.tap(find.byKey(const Key('point-adjustment-submit')));
    await tester.pumpAndSettle();

    expect(repository.lastType, 'DEPOSIT');
    expect(repository.lastAmount, 75);
    expect(repository.lastDescription, 'event bonus');
  });
}
