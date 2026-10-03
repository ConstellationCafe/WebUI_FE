import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/modules/academy/constants/academy_constants.dart';
import 'package:constellation_cafe/feature/modules/academy/constants/academy_strings.dart';
import 'package:constellation_cafe/shared/widgets/date_time/app_time_button.dart';
import 'package:constellation_cafe/shared/widgets/date_time/app_time_picker.dart';

import '../../../domain/model/lesson_record/lesson_time_range.dart';
import '../academy_field_label.dart';

class AcademyTimeRangeField extends StatelessWidget {
  final DateTime? startTime;
  final DateTime? endTime;

  final ValueChanged<DateTime> onStartTimeChanged;
  final ValueChanged<DateTime> onEndTimeChanged;

  /// 선택한 시각을 붙일 날짜(오늘)를 정한다. 테스트에서 주입한다.
  final DateTime Function() clock;

  const AcademyTimeRangeField({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    this.clock = DateTime.now,
  });

  bool get _endsNextDay =>
      startTime != null &&
      endTime != null &&
      LessonTimeRange.endsNextDay(startTime!, endTime!);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AcademyFieldLabel(AcademyStrings.educationTime, isRequired: true),
        const SizedBox(height: AcademyConstants.fieldLabelGap),
        Row(
          children: [
            Expanded(
              child: AppTimeButton(
                value: startTime,
                onPressed: () => _pickTime(
                  context,
                  current: startTime,
                  fallback: AcademyConstants.defaultLessonStartTime,
                  onPicked: onStartTimeChanged,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AcademyConstants.timeRangeSeparatorPadding,
              ),
              child: Text(AcademyStrings.timeRangeSeparator),
            ),
            Expanded(
              child: AppTimeButton(
                value: endTime,
                onPressed: () => _pickTime(
                  context,
                  current: endTime,
                  fallback: AcademyConstants.defaultLessonEndTime,
                  onPicked: onEndTimeChanged,
                ),
              ),
            ),
          ],
        ),
        if (_endsNextDay) ...[
          const SizedBox(height: AcademyConstants.fieldLabelGap),
          Text(
            AcademyStrings.endsNextDay,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }

  Future<void> _pickTime(
    BuildContext context, {
    required DateTime? current,
    required TimeOfDay fallback,
    required ValueChanged<DateTime> onPicked,
  }) async {
    final time = await showAppTimePicker(
      context: context,
      initialTime: current != null ? TimeOfDay.fromDateTime(current) : fallback,
    );
    if (time == null) return;
    final now = clock();
    onPicked(DateTime(now.year, now.month, now.day, time.hour, time.minute));
  }
}
