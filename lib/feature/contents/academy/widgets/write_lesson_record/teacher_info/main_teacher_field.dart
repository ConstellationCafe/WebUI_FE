import 'package:flutter/material.dart';

import '../../../domain/model/teacher.dart';

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
        _label(
          context,
          '담당 교사 (나)',
          required: true,
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<Teacher>(
          value: selectedTeacher,
          hint: const Text('담당 교사를 선택하세요'),
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