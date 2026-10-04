import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/modules/academy/constants/academy_strings.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/teacher.dart';

import '../academy_responsive_row.dart';
import '../academy_section_card.dart';
import 'co_teacher_field.dart';
import 'main_teacher_field.dart';

class AcademyTeacherInfo extends StatelessWidget {
  final List<Teacher> teachers;
  final List<Teacher> coTeachers;
  final Teacher? mainTeacher;
  final List<Teacher> selectedCoTeachers;

  final ValueChanged<Teacher> onMainTeacherChanged;
  final ValueChanged<Teacher> onCoTeacherToggle;

  const AcademyTeacherInfo({
    super.key,
    required this.teachers,
    required this.coTeachers,
    required this.mainTeacher,
    required this.selectedCoTeachers,
    required this.onMainTeacherChanged,
    required this.onCoTeacherToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AcademySectionCard(
      title: AcademyStrings.teacherInfo,
      icon: Icons.person_outline_rounded,
      child: AcademyResponsiveRow(
        equalHeight: true,
        children: [
          MainTeacherField(
            teachers: teachers,
            selectedTeacher: mainTeacher,
            onChanged: onMainTeacherChanged,
          ),
          CoTeacherField(
            teachers: coTeachers,
            mainTeacher: mainTeacher,
            selectedCoTeachers: selectedCoTeachers,
            onChanged: onCoTeacherToggle,
          ),
        ],
      ),
    );
  }
}
