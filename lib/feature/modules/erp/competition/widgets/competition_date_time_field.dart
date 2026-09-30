import 'package:flutter/material.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';

/// 날짜와 시간을 차례로 고르는 입력란. 값은 브라우저 현지 시각이다.
/// 이미 시작된 접수처럼 과거 시각도 고를 수 있다.
class CompetitionDateTimeField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final bool enabled;
  final String? errorText;

  /// 값이 없을 때 달력이 처음 보여줄 날짜와 선택 범위의 기준. 테스트에서 주입한다.
  final DateTime Function() clock;

  const CompetitionDateTimeField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.errorText,
    this.clock = DateTime.now,
  });

  @override
  Widget build(BuildContext context) {
    final current = value;
    final theme = Theme.of(context);
    return InkWell(
      onTap: enabled ? () => _pick(context) : null,
      child: InputDecorator(
        // 라벨을 항상 위에 두어, 값이 없을 때 안내 문구와 라벨이 겹치지 않게 한다.
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabled: enabled,
          errorText: errorText,
          suffixIcon: const Icon(Icons.event_outlined),
        ),
        child: Text(
          current == null
              ? CompetitionStrings.selectDateTime
              : CompetitionStrings.formatDateTime(current),
          style: current == null ? theme.inputDecorationTheme.hintStyle : null,
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final now = clock();
    final today = DateTime(now.year, now.month, now.day);
    const range = Duration(days: CompetitionTokens.selectableDays);
    final firstDate = today.subtract(range);
    final lastDate = today.add(range);
    final initial = value ?? now;
    final initialDate = initial.isBefore(firstDate)
        ? firstDate
        : (initial.isAfter(lastDate) ? lastDate : initial);

    final date = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: initialDate,
      builder: _pickerTheme,
    );
    if (date == null || !context.mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
      builder: _pickerTheme,
    );
    if (time == null) return;
    onChanged(
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
    );
  }

  /// 앱 theme의 primary가 흰색이라 선택기 버튼 글자가 보이지 않으므로 secondary로 바꾼다.
  Widget _pickerTheme(BuildContext context, Widget? child) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.secondary,
          ),
        ),
      ),
      child: child!,
    );
  }
}
