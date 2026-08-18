import 'package:flutter/material.dart';

import '../../../domain/model/teacher.dart';

class MainTeacherField extends StatelessWidget {
  final List<AcademyTeacher> teachers;
  final AcademyTeacher? selectedTeacher;
  final ValueChanged<AcademyTeacher> onChanged;

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
        _label(
          context,
          '담당 교사 (나)',
          required: true,
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: selectedTeacher?.id,
          hint: const Text('담당 교사를 선택하세요'),
          items: teachers
              .map(
                (teacher) => DropdownMenuItem<String>(
              value: teacher.id,
              child: Text(teacher.name),
            ),
          )
              .toList(),
          onChanged: (value) {
            if (value == null) return;

            final teacher = teachers.firstWhere(
                  (teacher) => teacher.id == value,
            );

            onChanged(teacher);
          },
        ),
      ],
    );
  }

  Widget _label(
      BuildContext context,
      String text, {
        required bool required,
      }) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelLarge,
        children: [
          TextSpan(text: text),
          if (required)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}