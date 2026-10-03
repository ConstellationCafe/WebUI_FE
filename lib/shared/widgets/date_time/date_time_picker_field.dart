import 'package:flutter/material.dart';

import '../../constants/date_time_picker_strings.dart';
import '../../constants/date_time_picker_tokens.dart';
import 'app_date_picker_theme.dart';
import 'app_time_button.dart';
import 'app_time_picker.dart';

/// 날짜 입력란과 시간 입력란을 나란히 둔 입력. 값은 브라우저 현지 시각이다.
///
/// 한 칸에서 날짜와 시간을 함께 고르면 헷갈리므로 `{label} 날짜`, `{label} 시간` 두 칸으로
/// 나눈다. 시간 칸은 앱 공용 [AppTimeButton]과 `showAppTimePicker`를 쓴다.
/// - 값이 없을 때 날짜를 고르면 이어서 시간 선택기가 열린다.
/// - 값이 있으면 날짜만, 또는 시간만 바꿀 수 있다(나머지는 유지).
/// - [clearable]이면 값을 지울 수 있고, 지우면 [onChanged]에 null을 넘긴다.
///
/// 범위를 벗어난 시각(예: 오늘 날짜의 미래 시간)은 호출부에서 검증한다.
class DateTimePickerField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool enabled;
  final bool clearable;
  final String? errorText;
  final String? helperText;

  /// 값이 없을 때 선택기가 처음 보여줄 날짜·시간. 테스트에서 주입한다.
  final DateTime Function() clock;

  const DateTimePickerField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.firstDate,
    required this.lastDate,
    this.enabled = true,
    this.clearable = false,
    this.errorText,
    this.helperText,
    this.clock = DateTime.now,
  });

  @override
  Widget build(BuildContext context) {
    final current = value;
    final canClear = clearable && enabled && current != null;
    final theme = Theme.of(context);
    final error = errorText;
    final helper = helperText;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: AppDateButton(
                label: DateTimePickerStrings.dateLabel(label),
                value: current,
                onPressed: enabled ? () => _pickDate(context) : null,
              ),
            ),
            const SizedBox(width: DateTimePickerTokens.segmentGap),
            Expanded(
              child: AppTimeButton(
                label: DateTimePickerStrings.timeLabel(label),
                value: current,
                placeholder: DateTimePickerStrings.selectTime,
                onPressed: enabled ? () => _pickTime(context) : null,
              ),
            ),
            if (canClear)
              IconButton(
                tooltip: DateTimePickerStrings.clear,
                onPressed: () => onChanged(null),
                icon: const Icon(Icons.close),
              ),
          ],
        ),
        if (error != null || helper != null)
          Padding(
            padding: const EdgeInsets.only(
              top: DateTimePickerTokens.subtextTopGap,
              left: DateTimePickerTokens.subtextHorizontalPadding,
            ),
            child: Text(
              error ?? helper!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: error != null ? theme.colorScheme.error : null,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final first = DateUtils.dateOnly(firstDate);
    final last = DateUtils.dateOnly(lastDate);
    final initial = DateUtils.dateOnly(value ?? clock());
    final date = await showDatePicker(
      context: context,
      firstDate: first,
      lastDate: last,
      initialDate: initial.isBefore(first)
          ? first
          : (initial.isAfter(last) ? last : initial),
      builder: (context, child) => AppDatePickerTheme(child: child!),
    );
    if (date == null || !context.mounted) return;

    final current = value;
    if (current != null) {
      onChanged(_combine(date, TimeOfDay.fromDateTime(current)));
      return;
    }
    // 처음 고를 때는 시간도 이어서 고른다. 시간 선택을 취소하면 값을 바꾸지 않는다.
    final time = await showAppTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(clock()),
    );
    if (time == null) return;
    onChanged(_combine(date, time));
  }

  Future<void> _pickTime(BuildContext context) async {
    final base = value ?? clock();
    final time = await showAppTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(base),
    );
    if (time == null) return;
    onChanged(_combine(base, time));
  }

  static DateTime _combine(DateTime date, TimeOfDay time) =>
      DateTime(date.year, date.month, date.day, time.hour, time.minute);
}
