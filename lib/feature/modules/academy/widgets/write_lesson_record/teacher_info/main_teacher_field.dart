import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/modules/academy/constants/academy_constants.dart';
import 'package:constellation_cafe/feature/modules/academy/constants/academy_strings.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/teacher.dart';

import '../academy_field_label.dart';

class MainTeacherField extends StatelessWidget {
  final List<Teacher> teachers;
  final Teacher? selectedTeacher;
  final ValueChanged<Teacher> onChanged;

  const MainTeacherField({
    super.key,
    required this.teachers,
    required this.selectedTeacher,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AcademyFieldLabel(AcademyStrings.mainTeacher, isRequired: true),
        const SizedBox(height: AcademyConstants.fieldLabelGap),
        DropdownButtonFormField<Teacher>(
          // 선택 값은 notifier state가 소유하므로 controlled value를 유지한다.
          // ignore: deprecated_member_use
          value: selectedTeacher,
          hint: const Text(AcademyStrings.selectMainTeacher),
          items: teachers
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
      ],
    );
  }
}
