import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/feature/modules/academy/constants/academy_constants.dart';
import 'package:constellation_cafe/feature/modules/academy/constants/academy_strings.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/academy.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/academy_class.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/subject.dart';

import 'academy_dropdown.dart';
import 'class_dropdown.dart';
import 'date_field.dart';
import 'subject_dropdown.dart';
import 'time_dropdown.dart';

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
    // 조회·초기화 버튼을 마지막 조회 조건 바로 옆에 두어, 조건과 버튼이 한 묶음으로
    // 보이게 한다. 화면이 좁으면 버튼도 조건과 함께 다음 줄로 넘어간다.
    return Wrap(
      spacing: ConstPadding.smallPadding,
      runSpacing: ConstPadding.smallPadding,
      crossAxisAlignment: WrapCrossAlignment.center,
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
              onPressed: isLoading ? null : onReset,
              child: const Text(AcademyStrings.reset),
            ),
            const SizedBox(width: ConstPadding.smallPadding),
            ElevatedButton(
              onPressed: isLoading ? null : onSearch,
              child: const Text(AcademyStrings.search),
            ),
          ],
        ),
      ],
    );
  }
}
