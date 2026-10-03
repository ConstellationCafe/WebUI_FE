import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/utils/date_formatter.dart';
import 'package:constellation_cafe/shared/widgets/date_time/app_picker_theme.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';

/// 날짜만 고르는 입력란. 대회 개최 날짜처럼 과거부터 오늘까지만 고를 수 있다.
class CompetitionDateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final bool enabled;
  final String? errorText;

  /// 오늘 날짜의 기준. 테스트에서 주입한다.
  final DateTime Function() clock;

  const CompetitionDateField({
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
              ? CompetitionStrings.selectDate
              : DateFormatter.toYyyyMmDd(current),
          style: current == null ? theme.inputDecorationTheme.hintStyle : null,
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final now = clock();
    final today = DateTime(now.year, now.month, now.day);
    final firstDate = DateTime(today.year - CompetitionTokens.winnerYearsBack);
    final date = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: today,
      initialDate: value ?? today,
      builder: (context, child) => AppPickerTheme(child: child!),
    );
    if (date != null) onChanged(date);
  }
}
