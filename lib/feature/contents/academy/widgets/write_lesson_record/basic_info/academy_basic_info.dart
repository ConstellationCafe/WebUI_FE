import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../../domain/model/academy.dart';
import '../../../domain/model/academy_class.dart';
import '../../../domain/model/subject.dart';
import '../academy_section_card.dart';
import 'academy_date_field.dart';
import 'academy_selection_fields.dart';
import 'academy_time_range_field.dart';

class AcademyBasicInfo extends StatelessWidget {
  final List<Academy> academies;
  final List<AcademyClass> classes;
  final List<Subject> subjects;

  final Academy? selectedAcademy;
  final AcademyClass? selectedAcademyClass;
  final Subject? selectedSubject;

  final DateTime? educationDate;
  final DateTime? startTime;
  final DateTime? endTime;

  final ValueChanged<Academy> onAcademyChanged;
  final ValueChanged<AcademyClass> onClassChanged;
  final ValueChanged<Subject> onSubjectChanged;

  final ValueChanged<DateTime> onEducationDateChanged;
  final ValueChanged<DateTime> onStartTimeChanged;
  final ValueChanged<DateTime> onEndTimeChanged;

  const AcademyBasicInfo({
    super.key,
    required this.academies,
    required this.classes,
    required this.subjects,
    required this.selectedAcademy,
    required this.selectedAcademyClass,
    required this.selectedSubject,
    required this.educationDate,
    required this.startTime,
    required this.endTime,
    required this.onAcademyChanged,
    required this.onClassChanged,
    required this.onSubjectChanged,
    required this.onEducationDateChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AcademySectionCard(
      title: '기본 정보',
      icon: Icons.menu_book_rounded,
      child: Column(
        children: [
          AcademySelectionFields(
            academies: academies,
            classes: classes,
            subjects: subjects,
            selectedAcademy: selectedAcademy,
            selectedAcademyClass: selectedAcademyClass,
            selectedSubject: selectedSubject,
            onAcademyChanged: onAcademyChanged,
            onClassChanged: onClassChanged,
            onSubjectChanged: onSubjectChanged,
          ),
          const SizedBox(
            height: ConstPadding.mediumPadding,
          ),
          Row(
            children: [
              Expanded(
                child: AcademyDateField(
                  date: educationDate,
                  onChanged: onEducationDateChanged,
                ),
              ),
              const SizedBox(
                width: ConstPadding.mediumPadding,
              ),
              Expanded(
                child: AcademyTimeRangeField(
                  startTime: startTime,
                  endTime: endTime,
                  onStartTimeChanged: onStartTimeChanged,
                  onEndTimeChanged: onEndTimeChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}