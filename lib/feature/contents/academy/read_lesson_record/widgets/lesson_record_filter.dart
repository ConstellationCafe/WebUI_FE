import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';

class LessonRecordFilter extends StatelessWidget {
  final DateTime? selectedDate;
  final String? selectedTime;
  final String? selectedSubject;

  final ValueChanged<DateTime?> onDateChanged;
  final ValueChanged<String?> onTimeChanged;
  final ValueChanged<String?> onSubjectChanged;

  final VoidCallback onSearch;
  final VoidCallback onReset;

  const LessonRecordFilter({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedSubject,
    required this.onDateChanged,
    required this.onTimeChanged,
    required this.onSubjectChanged,
    required this.onSearch,
    required this.onReset,
  });

  static const List<String> _timeOptions = [
    '전체',
    '오전',
    '오후',
  ];

  static const List<String> _subjectOptions = [
    '전체',
    '국어',
    '영어',
    '수학',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: ConstPadding.smallPadding,
      runSpacing: ConstPadding.smallPadding,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        SizedBox(
          width: AcademyConstants.filterFieldWidth,
          child: _dateField(context),
        ),

        SizedBox(
          width: AcademyConstants.filterFieldWidth,
          child: _dropdown(
            label: '시간',
            value: selectedTime ?? '전체',
            items: _timeOptions,
            onChanged: (value) {
              onTimeChanged(
                value == '전체' ? null : value,
              );
            },
          ),
        ),

        SizedBox(
          width: AcademyConstants.filterFieldWidth,
          child: _dropdown(
            label: '과목',
            value: selectedSubject ?? '전체',
            items: _subjectOptions,
            onChanged: (value) {
              onSubjectChanged(
                value == '전체' ? null : value,
              );
            },
          ),
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: onSearch,
              child: const Text('조회'),
            ),
            const SizedBox(
              width: ConstPadding.smallPadding,
            ),
            ElevatedButton(
              onPressed: onReset,
              child: const Text('초기화'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dateField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '날짜',
          style: Theme.of(context)
              .textTheme
              .labelLarge,
        ),
        const SizedBox(
          height: ConstPadding.tinyPadding,
        ),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
              initialDate: selectedDate ?? DateTime.now(),
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
              onDateChanged(date);
            }
          },
          child: InputDecorator(
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.calendar_today_outlined,
              ),
            ),
            child: Text(
              selectedDate == null
                  ? '전체'
                  : _formatDate(selectedDate!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
      ),
      items: items
          .map(
            (item) => DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      )
          .toList(),
      onChanged: onChanged,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}. '
        '${date.month.toString().padLeft(2, '0')}. '
        '${date.day.toString().padLeft(2, '0')}';
  }
}