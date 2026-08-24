import 'package:constellation_cafe/feature/contents/academy/widgets/read_lesson_record/lesson_record_filter/subject_dropdown.dart';
import 'package:constellation_cafe/feature/contents/academy/widgets/read_lesson_record/lesson_record_filter/time_dropdown.dart';
import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../../constants/academy_constants.dart';
import '../../../domain/model/academy.dart';
import '../../../domain/model/academy_class.dart';
import '../../../domain/model/subject.dart';
import 'academy_dropdown.dart';
import 'class_dropdown.dart';
import 'date_field.dart';

class LessonRecordFilter extends StatelessWidget {
  final List<Academy> academies;
  final List<AcademyClass> classes;
  final List<Subject> subjects;

  final int? selectedAcademyId;
  final int? selectedClassId;
  final int? selectedSubjectId;

  final DateTime? selectedDate;
  final DateTime? selectedTime;

  final bool isLoading;

  final ValueChanged<Academy> onAcademyChanged;
  final ValueChanged<AcademyClass> onClassChanged;
  final ValueChanged<Subject> onSubjectChanged;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<DateTime> onTimeChanged;

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

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: ConstPadding.smallPadding,
      runSpacing: ConstPadding.smallPadding,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        SizedBox(
          width: AcademyConstants.filterFieldWidth,
          child: AcademyDropdown(
            academies: academies,
            selectedAcademyId: selectedAcademyId,
            isLoading: isLoading,
            onChanged: onAcademyChanged,
          ),
        ),
        SizedBox(
          width: AcademyConstants.filterFieldWidth,
          child: ClassDropdown(
            classes: classes,
            selectedClassId: selectedClassId,
            onChanged: onClassChanged,
          ),
        ),
        SizedBox(
          width: AcademyConstants.filterFieldWidth,
          child: SubjectDropdown(
            subjects: subjects,
            selectedSubjectId: selectedSubjectId,
            onChanged: onSubjectChanged,
          ),
        ),
        SizedBox(
          width: AcademyConstants.filterFieldWidth,
          child: DateField(
            selectedDate: selectedDate,
            onChanged: onDateChanged,
          ),
        ),
        SizedBox(
          width: AcademyConstants.filterFieldWidth,
          child: TimeDropdown(
            selectedTime: selectedTime,
            onChanged: onTimeChanged,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: isLoading ? null : onSearch,
              child: const Text('조회'),
            ),
            const SizedBox(
              width: ConstPadding.smallPadding,
            ),
            ElevatedButton(
              onPressed: isLoading ? null : onReset,
              child: const Text('초기화'),
            ),
          ],
        ),
      ],
    );
  }
}