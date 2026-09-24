import 'dart:async';

import 'package:flutter/material.dart';
import 'package:constellation_cafe/core/constants/theme_data.dart';
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
      theme: CustomTheme.themeData,
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
  testWidgets('취소 버튼은 공통 버튼 테마에서 읽을 수 있는 대비를 가진다', (tester) async {
    await openDialog(tester, onSubmit: (_, _) async => true);
    final button = find.widgetWithText(ElevatedButton, PointStrings.cancel);
    expect(button, findsOneWidget);
    final material = tester.widget<Material>(
      find.descendant(of: button, matching: find.byType(Material)).first,
    );
    final foreground = DefaultTextStyle.of(
      tester.element(find.text(PointStrings.cancel)),
    ).style.color!;
    final background = material.color!;
    final light = foreground.computeLuminance();
    final dark = background.computeLuminance();
    final contrast = light > dark
        ? (light + 0.05) / (dark + 0.05)
        : (dark + 0.05) / (light + 0.05);
    expect(contrast, greaterThanOrEqualTo(4.5));
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.byType(PointTransactionDialog), findsNothing);
  });

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
      tester.widget<ElevatedButton>(find.byType(ElevatedButton).last).onPressed,
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
      tester.widget<ElevatedButton>(find.byType(ElevatedButton).last).onPressed,
      isNull,
    );
    await tester.tap(find.text(PointStrings.cancel));
    await tester.pumpAndSettle();
    expect(find.byType(PointTransactionDialog), findsNothing);
  });
}
