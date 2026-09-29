import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/modules/academy/constants/academy_constants.dart';
import 'package:constellation_cafe/feature/modules/academy/constants/academy_strings.dart';

class TimeDropdown extends StatelessWidget {
  final DateTime? selectedTime;
  final ValueChanged<DateTime> onChanged;

  /// 오전·오후 선택값에 붙일 날짜(오늘)를 정한다. 테스트에서 주입한다.
  final DateTime Function() clock;

  const TimeDropdown({
    super.key,
    required this.selectedTime,
    required this.onChanged,
    this.clock = DateTime.now,
  });

  static const List<String> _timeOptions = [
    AcademyStrings.morning,
    AcademyStrings.afternoon,
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<DateTime?>(
      initialValue: selectedTime,
      decoration: const InputDecoration(labelText: AcademyStrings.time),
      items: [
        const DropdownMenuItem<DateTime?>(
          value: null,
          child: Text(AcademyStrings.all),
        ),
        ..._timeOptions.map((time) {
          final now = clock();
          final hour = time == AcademyStrings.morning
              ? AcademyConstants.morningFilterHour
              : AcademyConstants.afternoonFilterHour;
          final value = DateTime(now.year, now.month, now.day, hour);

          return DropdownMenuItem<DateTime?>(value: value, child: Text(time));
        }),
      ],
      onChanged: (time) {
        if (time == null) {
          return;
        }

        onChanged(time);
      },
    );
  }
}
