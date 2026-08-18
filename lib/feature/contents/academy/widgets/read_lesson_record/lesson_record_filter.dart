import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/subject.dart';

class LessonRecordFilter extends StatelessWidget {
  final List<Academy> academies;
  final List<AcademyClass> classes;
  final List<Subject> subjects;

  final String? selectedAcademyId;
  final String? selectedClassId;
  final String? selectedSubjectId;

  final DateTime? selectedDate;
  final String? selectedTime;

  final bool isLoading;

  final ValueChanged<String?> onAcademyChanged;
  final ValueChanged<String?> onClassChanged;
  final ValueChanged<String?> onSubjectChanged;
  final ValueChanged<DateTime?> onDateChanged;
  final ValueChanged<String?> onTimeChanged;

  final VoidCallback onSearch;
  final VoidCallback onReset;

  const LessonRecordFilter({
    super.key,
    required this.academies,
    required this.classes,
    required this.subjects,
    required this.selectedAcademyId,
    required this.selectedClassId,
    required this.selectedSubjectId,
    required this.selectedDate,
    required this.selectedTime,
    required this.isLoading,
    required this.onAcademyChanged,
    required this.onClassChanged,
    required this.onSubjectChanged,
    required this.onDateChanged,
    required this.onTimeChanged,
    required this.onSearch,
    required this.onReset,
  });

  static const List<String> _timeOptions = [
    '오전',
    '오후',
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
          child: _academyDropdown(),
        ),
        SizedBox(
          width: AcademyConstants.filterFieldWidth,
          child: _classDropdown(),
        ),
        SizedBox(
          width: AcademyConstants.filterFieldWidth,
          child: _subjectDropdown(),
        ),
        SizedBox(
          width: AcademyConstants.filterFieldWidth,
          child: _dateField(context),
        ),
        SizedBox(
          width: AcademyConstants.filterFieldWidth,
          child: _timeDropdown(),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : onSearch,
              child: const Text('조회'),
            ),
            const SizedBox(
              width: ConstPadding.smallPadding,
            ),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : onReset,
              child: const Text('초기화'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _academyDropdown() {
    return DropdownButtonFormField<String?>(
      initialValue: selectedAcademyId,
      decoration: const InputDecoration(
        labelText: '아카데미',
      ),
      items: [
        const DropdownMenuItem<String?>(
          value: null,
          child: Text('전체'),
        ),
        ...academies.map(
              (academy) => DropdownMenuItem<String?>(
            value: academy.id,
            child: Text(academy.name),
          ),
        ),
      ],
      onChanged: isLoading
          ? null
          : onAcademyChanged,
    );
  }

  Widget _classDropdown() {
    return DropdownButtonFormField<String?>(
      initialValue: selectedClassId,
      decoration: const InputDecoration(
        labelText: '분반',
      ),
      items: [
        const DropdownMenuItem<String?>(
          value: null,
          child: Text('전체'),
        ),
        ...classes.map(
              (academyClass) => DropdownMenuItem<String?>(
            value: academyClass.id.toString(),
            child: Text(
              '${academyClass.classNumber}분반',
            ),
          ),
        ),
      ],
      onChanged: classes.isEmpty
          ? null
          : onClassChanged,
    );
  }

  Widget _subjectDropdown() {
    return DropdownButtonFormField<String?>(
      initialValue: selectedSubjectId,
      decoration: const InputDecoration(
        labelText: '과목',
      ),
      items: [
        const DropdownMenuItem<String?>(
          value: null,
          child: Text('전체'),
        ),
        ...subjects.map(
              (subject) => DropdownMenuItem<String?>(
            value: subject.id.toString(),
            child: Text(subject.name),
          ),
        ),
      ],
      onChanged: subjects.isEmpty
          ? null
          : onSubjectChanged,
    );
  }

  Widget _timeDropdown() {
    return DropdownButtonFormField<String?>(
      initialValue: selectedTime,
      decoration: const InputDecoration(
        labelText: '시간',
      ),
      items: [
        const DropdownMenuItem<String?>(
          value: null,
          child: Text('전체'),
        ),
        ..._timeOptions.map(
              (time) => DropdownMenuItem<String?>(
            value: time,
            child: Text(time),
          ),
        ),
      ],
      onChanged: onTimeChanged,
    );
  }

  Widget _dateField(
      BuildContext context,
      ) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
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
              initialDate:
              selectedDate ?? DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    textButtonTheme:
                    TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor:
                        colorScheme.secondary,
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

  String _formatDate(DateTime date) {
    return '${date.year}. '
        '${date.month.toString().padLeft(2, '0')}. '
        '${date.day.toString().padLeft(2, '0')}';
  }
}