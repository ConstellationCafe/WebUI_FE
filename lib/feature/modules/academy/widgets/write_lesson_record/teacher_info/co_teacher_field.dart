import 'package:flutter/material.dart';

import '../../../domain/model/teacher.dart';

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
        .where(
          (teacher) => teacher.sk != mainTeacher?.sk,
    )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(
          context,
          '함께 가르친 교사',
          required: false,
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<Teacher>(
          hint: const Text('교사 이름을 선택하세요'),
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
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
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