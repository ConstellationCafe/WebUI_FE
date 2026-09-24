import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/modules/erp/point/constants/point_strings.dart';
import 'package:constellation_cafe/feature/modules/erp/point/widgets/point_transaction_dialog.dart';

import 'support/fake_admin_point_repository.dart';

Future<void> openDialog(
  WidgetTester tester, {
  bool isDeposit = true,
  required Future<bool> Function(int, String) onSubmit,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () => showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (_) => PointTransactionDialog(
                isDeposit: isDeposit,
                member: pointMember('123'),
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
  testWidgets('잘못된 금액과 잔액을 넘는 출금을 제출하지 않는다', (tester) async {
    int count = 0;
    await openDialog(
      tester,
      isDeposit: false,
      onSubmit: (_, _) async {
        count++;
        return true;
      },
    );
    await tester.enterText(find.byType(TextFormField).first, '0');
    await tester.tap(find.text(PointStrings.apply));
    await tester.pumpAndSettle();
    expect(find.text(PointStrings.invalidAmount), findsOneWidget);
    expect(find.text(PointStrings.descriptionRequired), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).first, '100000001');
    await tester.enterText(find.byType(TextFormField).last, '차감');
    await tester.tap(find.text(PointStrings.apply));
    await tester.pumpAndSettle();
    expect(find.text(PointStrings.invalidAmount), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).first, '1201');
    await tester.tap(find.text(PointStrings.apply));
    await tester.pumpAndSettle();
    expect(find.text(PointStrings.insufficientBalance), findsOneWidget);
    expect(count, 0);
  });

  testWidgets('처리 중 닫기와 중복 제출을 막고 성공하면 창을 닫는다', (tester) async {
    final pending = Completer<bool>();
    int count = 0;
    await openDialog(
      tester,
      onSubmit: (amount, description) {
        count++;
        expect(amount, 500);
        expect(description, '이벤트 지급');
        return pending.future;
      },
    );
    await tester.enterText(find.byType(TextFormField).first, '500');
    await tester.enterText(find.byType(TextFormField).last, ' 이벤트 지급 ');
    await tester.tap(find.text(PointStrings.apply));
    await tester.pump();
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    await tester.tap(find.text(PointStrings.cancel));
    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(find.byType(PointTransactionDialog), findsOneWidget);
    expect(count, 1);
    pending.complete(true);
    await tester.pumpAndSettle();
    expect(find.byType(PointTransactionDialog), findsNothing);
  });

  testWidgets('결과가 불확실한 실패는 잔액 확인을 안내하고 재전송하지 않는다', (tester) async {
    await openDialog(tester, onSubmit: (_, _) async => false);
    await tester.enterText(find.byType(TextFormField).first, '100');
    await tester.enterText(find.byType(TextFormField).last, '지급');
    await tester.tap(find.text(PointStrings.apply));
    await tester.pumpAndSettle();
    expect(find.text(PointStrings.transactionFailed), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    await tester.tap(find.text(PointStrings.cancel));
    await tester.pumpAndSettle();
    expect(find.byType(PointTransactionDialog), findsNothing);
  });
}
