import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/modules/erp/point/constants/point_strings.dart';
import 'package:constellation_cafe/feature/modules/erp/point/notifier/admin_point_notifier.dart';
import 'package:constellation_cafe/feature/modules/erp/point/pages/admin_point_page.dart';
import 'package:constellation_cafe/feature/modules/erp/point/widgets/point_transaction_dialog.dart';

import 'support/fake_admin_point_repository.dart';

void main() {
  testWidgets('작은 화면과 큰 글자에서도 회원 선택과 입금 창을 사용할 수 있다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          adminPointRepositoryProvider.overrideWithValue(
            FakeAdminPointRepository(),
          ),
        ],
        child: MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(1.5)),
            child: child!,
          ),
          home: const Scaffold(body: AdminPointPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('별자리'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text(PointStrings.deposit));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.text(PointStrings.deposit));
    await tester.pumpAndSettle();
    expect(find.byType(PointTransactionDialog), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('회원 목록 오류에서 다시 조회할 수 있다', (tester) async {
    final repository = FakeAdminPointRepository()
      ..membersHandler = (_, _) => Future.error(StateError('unavailable'));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [adminPointRepositoryProvider.overrideWithValue(repository)],
        child: const MaterialApp(home: Scaffold(body: AdminPointPage())),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text(PointStrings.membersFailed), findsOneWidget);
    repository.membersHandler = null;
    await tester.tap(find.text(PointStrings.retry));
    await tester.pumpAndSettle();
    expect(find.text('별자리'), findsOneWidget);
    expect(find.text(PointStrings.membersFailed), findsNothing);
  });
}
