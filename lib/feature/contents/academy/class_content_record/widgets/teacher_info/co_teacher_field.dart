import 'package:flutter/material.dart';

import '../../domain/teacher.dart';

class CoTeacherField extends StatelessWidget {
  final List<AcademyTeacher> teachers;
  final AcademyTeacher? mainTeacher;
  final List<AcademyTeacher> selectedCoTeachers;

  final ValueChanged<AcademyTeacher> onChanged;

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
          (teacher) => teacher.id != mainTeacher?.id,
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
        DropdownButtonFormField<String>(
          hint: const Text('교사 이름을 선택하세요'),
          items: availableTeachers
              .map(
                (teacher) => DropdownMenuItem<String>(
              value: teacher.id,
              child: Text(teacher.name),
            ),
          )
              .toList(),
          onChanged: (value) {
            if (value == null) return;

            final teacher = availableTeachers.firstWhere(
                  (teacher) => teacher.id == value,
            );

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