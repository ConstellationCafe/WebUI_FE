import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/feature/modules/academy/constants/academy_constants.dart';
import 'package:constellation_cafe/feature/modules/academy/constants/academy_strings.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/teacher.dart';

import '../academy_field_label.dart';

class CoTeacherField extends StatelessWidget {
  final List<Teacher> teachers;
  final Teacher? mainTeacher;
  final List<Teacher> selectedCoTeachers;

  final ValueChanged<Teacher> onChanged;

  const CoTeacherField({
    super.key,
    required this.teachers,
    required this.mainTeacher,
    required this.selectedCoTeachers,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final availableTeachers = teachers
        .where((teacher) => teacher.sk != mainTeacher?.sk)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AcademyFieldLabel(AcademyStrings.coTeacher),
        const SizedBox(height: AcademyConstants.fieldLabelGap),
        DropdownButtonFormField<Teacher>(
          hint: const Text(AcademyStrings.selectTeacherName),
          items: availableTeachers
              .map(
                (teacher) => DropdownMenuItem<Teacher>(
                  value: teacher,
                  child: Text(teacher.name),
                ),
              )
              .toList(),
          onChanged: (teacher) {
            if (teacher == null) return;

            onChanged(teacher);
          },
        ),
        const SizedBox(height: ConstPadding.smallPadding),
        Wrap(
          spacing: AcademyConstants.memberChipSpacing,
          runSpacing: AcademyConstants.memberChipRunSpacing,
          children: selectedCoTeachers
              .map(
                (teacher) => Chip(
                  label: Text(teacher.name),
                  onDeleted: () {
                    onChanged(teacher);
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
