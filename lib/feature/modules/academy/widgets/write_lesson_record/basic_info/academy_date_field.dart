import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/modules/academy/constants/academy_constants.dart';
import 'package:constellation_cafe/feature/modules/academy/constants/academy_strings.dart';

import '../academy_field_label.dart';

class AcademyDateField extends StatelessWidget {
  final DateTime? date;
  final ValueChanged<DateTime> onChanged;

  /// 선택된 날짜가 없을 때 달력이 처음 보여줄 날짜. 테스트에서 주입한다.
  final DateTime Function() clock;

  const AcademyDateField({
    super.key,
    required this.date,
    required this.onChanged,
    this.clock = DateTime.now,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AcademyFieldLabel(AcademyStrings.educationDate, isRequired: true),
        const SizedBox(height: AcademyConstants.fieldLabelGap),
        InkWell(
          onTap: () async {
            final selectedDate = await showDatePicker(
              context: context,
              firstDate: AcademyConstants.firstSelectableDate,
              lastDate: AcademyConstants.lastSelectableDate,
              initialDate: date ?? clock(),
              builder: (context, child) {
                final colorScheme = Theme.of(context).colorScheme;
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
            if (selectedDate != null) {
              onChanged(selectedDate);
            }
          },
          child: InputDecorator(
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.calendar_today_outlined),
            ),
            child: Text(
              date == null
                  ? AcademyStrings.selectDate
                  : AcademyStrings.formatDate(date!),
            ),
          ),
        ),
      ],
    );
  }
}
