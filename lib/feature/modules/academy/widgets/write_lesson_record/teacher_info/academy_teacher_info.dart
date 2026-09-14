import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../../domain/model/teacher.dart';
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
      title: '교사 정보',
      icon: Icons.person_outline_rounded,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: MainTeacherField(
                teachers: teachers,
                selectedTeacher: mainTeacher,
                onChanged: onMainTeacherChanged,
              ),
            ),
            const SizedBox(
              width: ConstPadding.mediumPadding,
            ),
            Expanded(
              child: CoTeacherField(
                teachers: coTeachers,
                mainTeacher: mainTeacher,
                selectedCoTeachers: selectedCoTeachers,
                onChanged: onCoTeacherToggle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}