import 'package:flutter/material.dart';

import '../../constants/date_time_picker_strings.dart';
import '../../constants/date_time_picker_tokens.dart';
import 'app_date_picker_theme.dart';
import 'app_time_picker.dart';

/// 날짜와 시간을 따로 눌러 고르는 입력란. 값은 브라우저 현지 시각이다.
///
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
    return InputDecorator(
      // 라벨을 항상 위에 두어, 값이 없을 때 안내 문구와 라벨이 겹치지 않게 한다.
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabled: enabled,
        errorText: errorText,
        helperText: helperText,
        suffixIcon: canClear
            ? IconButton(
                tooltip: DateTimePickerStrings.clear,
                onPressed: () => onChanged(null),
                icon: const Icon(Icons.close),
              )
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: _Segment(
              icon: Icons.event_outlined,
              text: current == null
                  ? DateTimePickerStrings.selectDate
                  : DateTimePickerStrings.formatDate(current),
              semanticLabel: '$label ${DateTimePickerStrings.changeDate}',
              isEmpty: current == null,
              onTap: enabled ? () => _pickDate(context) : null,
            ),
          ),
          const SizedBox(width: DateTimePickerTokens.segmentGap),
          Expanded(
            child: _Segment(
              icon: Icons.access_time,
              text: current == null
                  ? DateTimePickerStrings.selectTime
                  : DateTimePickerStrings.formatTime(current),
              semanticLabel: '$label ${DateTimePickerStrings.changeTime}',
              isEmpty: current == null,
              onTap: enabled ? () => _pickTime(context) : null,
            ),
          ),
        ],
      ),
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
    final time = await _showTime(context, TimeOfDay.fromDateTime(clock()));
    if (time == null) return;
    onChanged(_combine(date, time));
  }

  Future<void> _pickTime(BuildContext context) async {
    final base = value ?? clock();
    final time = await _showTime(context, TimeOfDay.fromDateTime(base));
    if (time == null) return;
    onChanged(_combine(base, time));
  }

  Future<TimeOfDay?> _showTime(BuildContext context, TimeOfDay initial) {
    return showAppTimePicker(context: context, initialTime: initial);
  }

  static DateTime _combine(DateTime date, TimeOfDay time) =>
      DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

/// 날짜 또는 시간 한 칸. 눌러서 해당 선택기를 연다.
class _Segment extends StatelessWidget {
  final IconData icon;
  final String text;
  final String semanticLabel;
  final bool isEmpty;
  final VoidCallback? onTap;

  const _Segment({
    required this.icon,
    required this.text,
    required this.semanticLabel,
    required this.isEmpty,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = isEmpty ? theme.inputDecorationTheme.hintStyle : null;
    return Semantics(
      button: true,
      enabled: onTap != null,
      label: semanticLabel,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DateTimePickerTokens.segmentRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: DateTimePickerTokens.segmentVerticalPadding,
          ),
          child: Row(
            children: [
              Icon(icon, size: DateTimePickerTokens.segmentIconSize),
              const SizedBox(width: DateTimePickerTokens.segmentIconGap),
              Flexible(
                child: Text(
                  text,
                  style: style,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
