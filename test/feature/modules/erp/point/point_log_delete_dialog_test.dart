import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/modules/erp/point/constants/point_strings.dart';
import 'package:constellation_cafe/feature/modules/erp/point/domain/model/point_log.dart';
import 'package:constellation_cafe/feature/modules/erp/point/widgets/point_log_delete_dialog.dart';

import 'support/fake_admin_point_repository.dart';

Future<void> openDeleteDialog(
  WidgetTester tester, {
  int coin = 4200,
  int amount = -5800,
  required Future<bool> Function() onSubmit,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: CustomTheme.themeData,
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (_) => PointLogDeleteDialog(
                member: pointMember('123', coin: coin),
                log: PointLog(
                  amount: amount,
                  at: DateTime.utc(2026, 9, 24),
                  description: '차감',
                ),
                onSubmit: onSubmit,
              ),
            ),
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('-5,800 내역 삭제 시 잔액에 5,800이 복구됨을 안내한다', (tester) async {
    var count = 0;
    await openDeleteDialog(
      tester,
      onSubmit: () async {
        count++;
        return true;
      },
    );
    expect(find.textContaining('10,000 P'), findsOneWidget);
    await tester.tap(find.widgetWithText(ElevatedButton, PointStrings.delete));
    await tester.pumpAndSettle();
    expect(count, 1);
    expect(find.byType(PointLogDeleteDialog), findsNothing);
  });

  testWidgets('입금 내역 삭제로 잔액이 음수가 되면 제출하지 못한다', (tester) async {
    await openDeleteDialog(
      tester,
      coin: 100,
      amount: 500,
      onSubmit: () async => true,
    );
    expect(find.text(PointStrings.invalidResultingBalance), findsOneWidget);
    final deleteButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, PointStrings.delete),
    );
    expect(deleteButton.onPressed, isNull);
  });
}
