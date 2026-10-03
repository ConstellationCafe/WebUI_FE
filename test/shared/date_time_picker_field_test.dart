import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/core/constants/theme_data.dart';
import 'package:constellation_cafe/shared/constants/date_time_picker_strings.dart';
import 'package:constellation_cafe/shared/widgets/date_time/app_time_button.dart';
import 'package:constellation_cafe/shared/widgets/date_time/app_time_picker.dart';
import 'package:constellation_cafe/shared/widgets/date_time/date_time_picker_field.dart';

final _now = DateTime(2026, 10, 3, 20, 35);
DateTime _clock() => _now;

/// 바뀐 값을 화면에 반영하는 작은 host. 바뀐 값을 차례로 기록한다.
class _Host extends StatefulWidget {
  final DateTime? initial;
  final bool clearable;
  final void Function(DateTime?) record;

  const _Host({this.initial, this.clearable = false, required this.record});

  @override
  State<_Host> createState() => _HostState();
}

class _HostState extends State<_Host> {
  late DateTime? _value = widget.initial;

  @override
  Widget build(BuildContext context) {
    return DateTimePickerField(
      label: '시각',
      value: _value,
      firstDate: DateTime(2026, 1, 1),
      lastDate: DateTime(2026, 12, 31),
      clearable: widget.clearable,
      clock: _clock,
      onChanged: (value) {
        widget.record(value);
        setState(() => _value = value);
      },
    );
  }
}

Future<List<DateTime?>> _pump(
  WidgetTester tester, {
  DateTime? initial,
  bool clearable = false,
}) async {
  final changes = <DateTime?>[];
  await tester.pumpWidget(
    MaterialApp(
      theme: CustomTheme.themeData,
      home: Scaffold(
        body: _Host(
          initial: initial,
          clearable: clearable,
          record: changes.add,
        ),
      ),
    ),
  );
  return changes;
}

void main() {
  testWidgets('날짜와 시간을 각각의 입력란으로 나눠 안내를 보여준다', (tester) async {
    await _pump(tester);

    expect(find.text(DateTimePickerStrings.dateLabel('시각')), findsOneWidget);
    expect(find.text(DateTimePickerStrings.timeLabel('시각')), findsOneWidget);

    expect(find.text(DateTimePickerStrings.selectDate), findsOneWidget);
    expect(find.text(DateTimePickerStrings.selectTime), findsOneWidget);
    expect(find.byTooltip(DateTimePickerStrings.clear), findsNothing);
  });

  testWidgets('처음 날짜를 고르면 시간 선택기가 이어서 열리고 두 값을 합친다', (tester) async {
    final changes = await _pump(tester);

    await tester.tap(find.text(DateTimePickerStrings.selectDate));
    await tester.pumpAndSettle();
    expect(find.byType(DatePickerDialog), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.byType(TimePickerDialog), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(changes, [_now]);
    expect(find.text('2026-10-03'), findsOneWidget);
    expect(find.text('20:35'), findsOneWidget);
  });

  testWidgets('시간은 앱 공용 시간 선택기로 고른다', (tester) async {
    await _pump(tester, initial: _now);

    await tester.tap(find.text('20:35'));
    await tester.pumpAndSettle();

    expect(find.byType(TimePickerDialog), findsOneWidget);
    expect(find.byType(AppTimePickerTheme), findsOneWidget);
  });

  testWidgets('값이 있으면 시간을 바꿔도 날짜는 유지한다', (tester) async {
    final changes = await _pump(tester, initial: DateTime(2026, 9, 1, 9, 0));

    await tester.tap(find.text('09:00'));
    await tester.pumpAndSettle();
    expect(find.byType(DatePickerDialog), findsNothing);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(changes, [DateTime(2026, 9, 1, 9, 0)]);
    expect(find.text('2026-09-01'), findsOneWidget);
  });

  testWidgets('지울 수 있으면 값을 비운다', (tester) async {
    final changes = await _pump(tester, initial: _now, clearable: true);

    await tester.tap(find.byTooltip(DateTimePickerStrings.clear));
    await tester.pump();

    expect(changes, [null]);
    expect(find.text(DateTimePickerStrings.selectDate), findsOneWidget);
  });

  testWidgets('공용 시간 버튼은 값이 없으면 빈 시각, 있으면 HH:mm을 보여준다', (tester) async {
    Widget button(DateTime? value) => MaterialApp(
      home: Scaffold(
        body: AppTimeButton(value: value, onPressed: () {}),
      ),
    );

    await tester.pumpWidget(button(null));
    expect(find.text(DateTimePickerStrings.emptyTime), findsOneWidget);

    await tester.pumpWidget(button(DateTime(2026, 10, 3, 9, 5)));
    expect(find.text('09:05'), findsOneWidget);
  });
}
