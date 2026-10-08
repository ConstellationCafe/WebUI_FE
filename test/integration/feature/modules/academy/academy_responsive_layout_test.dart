import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/modules/academy/constants/academy_constants.dart';
import 'package:constellation_cafe/feature/modules/academy/widgets/read_status/status_summary.dart';
import 'package:constellation_cafe/feature/modules/academy/widgets/write_lesson_record/academy_responsive_row.dart';

const _a = ValueKey('a');
const _b = ValueKey('b');

int _columns(double width) => statusSummaryColumns(
  width: width,
  itemCount: 4,
  minItemWidth: AcademyConstants.statusSummaryItemMinWidth,
  spacing: AcademyConstants.statusSummarySpacing,
);

Future<void> _pumpRow(WidgetTester tester, double width) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: width,
            child: const AcademyResponsiveRow(
              children: [
                SizedBox(key: _a, height: 40),
                SizedBox(key: _b, height: 40),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('statusSummaryColumns', () {
    test('넓으면 4개 항목을 한 줄(4열)에 둔다', () {
      expect(_columns(1000), 4);
    });

    test('모바일 너비에서는 4행 1열 대신 2행 2열로 둔다', () {
      expect(_columns(260), 2);
    });

    test('3열만 들어가도 마지막 줄이 1개만 남지 않게 2열로 줄인다', () {
      expect(_columns(420), 2);
    });

    test('항목 최소 너비도 안 되면 1열로 둔다', () {
      expect(_columns(200), 1);
    });
  });

  group('AcademyResponsiveRow', () {
    testWidgets('좁으면 입력란을 세로로 쌓는다', (tester) async {
      await _pumpRow(tester, AcademyConstants.formStackBreakpoint - 1);

      final a = tester.getRect(find.byKey(_a));
      final b = tester.getRect(find.byKey(_b));
      expect(b.top, greaterThan(a.bottom));
      expect(a.width, AcademyConstants.formStackBreakpoint - 1);
    });

    testWidgets('넓으면 입력란을 같은 너비로 나란히 둔다', (tester) async {
      await _pumpRow(tester, AcademyConstants.formStackBreakpoint + 100);

      final a = tester.getRect(find.byKey(_a));
      final b = tester.getRect(find.byKey(_b));
      expect(b.top, a.top);
      expect(b.left, greaterThan(a.right));
      expect(a.width, b.width);
    });
  });
}
