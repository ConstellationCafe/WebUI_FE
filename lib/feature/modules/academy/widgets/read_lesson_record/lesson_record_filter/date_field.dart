import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/modules/academy/constants/academy_constants.dart';
import 'package:constellation_cafe/feature/modules/academy/constants/academy_strings.dart';

class DateField extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onChanged;

  /// 선택된 날짜가 없을 때 달력이 처음 보여줄 날짜. 테스트에서 주입한다.
  final DateTime Function() clock;

  const DateField({
    super.key,
    required this.selectedDate,
    required this.onChanged,
    this.clock = DateTime.now,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: AcademyConstants.firstSelectableDate,
          lastDate: AcademyConstants.lastSelectableDate,
          initialDate: selectedDate ?? clock(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.secondary,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );

        if (date != null) {
          onChanged(date);
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: AcademyStrings.date,
          suffixIcon: Icon(Icons.calendar_today_outlined),
        ),
        child: Text(
          selectedDate == null
              ? AcademyStrings.all
              : AcademyStrings.formatDate(selectedDate!),
        ),
      ),
    );
  }
}
