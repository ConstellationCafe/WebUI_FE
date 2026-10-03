import 'package:flutter/material.dart';

import 'package:constellation_cafe/shared/widgets/date_time/date_time_picker_field.dart';

import '../constants/competition_tokens.dart';

/// 대회 접수·시작 시각 입력란. 날짜와 시간을 따로 눌러 고르며 값은 브라우저 현지 시각이다.
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
    final today = DateUtils.dateOnly(clock());
    const range = Duration(days: CompetitionTokens.selectableDays);
    return DateTimePickerField(
      label: label,
      value: value,
      firstDate: today.subtract(range),
      lastDate: today.add(range),
      enabled: enabled,
      errorText: errorText,
      clock: clock,
      onChanged: (picked) {
        // 지우기를 제공하지 않으므로 null이 오지 않는다.
        if (picked != null) onChanged(picked);
      },
    );
  }
}
