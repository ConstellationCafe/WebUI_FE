import 'package:flutter/material.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';

/// 날짜와 시간을 차례로 고르는 입력란. 값은 브라우저 현지 시각이다.
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
    return InkWell(
      onTap: enabled ? () => _pick(context) : null,
      child: InputDecorator(
        isEmpty: current == null,
        decoration: InputDecoration(
          labelText: label,
          enabled: enabled,
          errorText: errorText,
          suffixIcon: const Icon(Icons.event_outlined),
        ),
        child: Text(
          current == null
              ? CompetitionStrings.selectDateTime
              : CompetitionStrings.formatDateTime(current),
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final now = clock();
    final today = DateTime(now.year, now.month, now.day);
    final initial = value ?? now;
    final date = await showDatePicker(
      context: context,
      firstDate: today,
      lastDate: today.add(
        const Duration(days: CompetitionTokens.selectableDays),
      ),
      initialDate: initial.isBefore(today) ? today : initial,
    );
    if (date == null || !context.mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return;
    onChanged(
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
    );
  }
}
