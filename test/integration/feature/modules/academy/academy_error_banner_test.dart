import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/feature/modules/academy/constants/academy_strings.dart';
import 'package:constellation_cafe/feature/modules/academy/widgets/academy_error_banner.dart';

Widget app(Widget child) => MaterialApp(
  theme: CustomTheme.themeData,
  home: Scaffold(body: child),
);

void main() {
  testWidgets('조회 실패 안내는 내부 오류 대신 고정 문구와 다시 시도를 보여준다', (tester) async {
    var retried = 0;
    await tester.pumpWidget(app(AcademyErrorBanner(onRetry: () => retried++)));

    expect(find.text(AcademyStrings.loadFailed), findsOneWidget);
    await tester.tap(find.text(AcademyStrings.retry));
    expect(retried, 1);
  });

  testWidgets('다시 시도할 동작이 없으면 버튼을 숨긴다', (tester) async {
    await tester.pumpWidget(app(const AcademyErrorBanner()));

    expect(find.text(AcademyStrings.loadFailed), findsOneWidget);
    expect(find.text(AcademyStrings.retry), findsNothing);
  });
}
