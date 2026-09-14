import 'package:flutter/material.dart';

import '../../../domain/model/academy.dart';
import '../../../domain/model/academy_class.dart';
import '../../../domain/model/subject.dart';

class AcademySelectionFields extends StatelessWidget {
  final List<Academy> academies;
  final List<AcademyClass> classes;
  final List<Subject> subjects;

  final Academy? selectedAcademy;
  final AcademyClass? selectedAcademyClass;
  final Subject? selectedSubject;

  final ValueChanged<Academy> onAcademyChanged;
  final ValueChanged<AcademyClass> onClassChanged;
  final ValueChanged<Subject> onSubjectChanged;

  const AcademySelectionFields({
    super.key,
    required this.academies,
    required this.classes,
    required this.subjects,
    required this.selectedAcademy,
    required this.selectedAcademyClass,
    required this.selectedSubject,
    required this.onAcademyChanged,
    required this.onClassChanged,
    required this.onSubjectChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _dropdown<Academy>(
            context,
            label: '아카데미 이름',
            hint: '아카데미를 선택하세요',
            value: selectedAcademy,
            items: academies
                .map(
                  (academy) => DropdownMenuItem<Academy>(
                value: academy,
                child: Text(academy.name),
              ),
            )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                onAcademyChanged(value);
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _dropdown<AcademyClass>(
            context,
            label: '분반',
            hint: '분반을 선택하세요',
            value: selectedAcademyClass,
            items: classes
                .map(
                  (academyClass) => DropdownMenuItem<AcademyClass>(
                value: academyClass,
                child: Text(
                  '${academyClass.classNumber}분반',
                ),
              ),
            )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                onClassChanged(value);
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _dropdown<Subject>(
            context,
            label: '과목',
            hint: '과목을 선택하세요',
            value: selectedSubject,
            items: subjects
                .map(
                  (subject) => DropdownMenuItem<Subject>(
                value: subject,
                child: Text(subject.name),
              ),
            )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                onSubjectChanged(value);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _dropdown<T>(
      BuildContext context, {
        required String label,
        required String hint,
        required T? value,
        required List<DropdownMenuItem<T>> items,
        required ValueChanged<T?> onChanged,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(
          context,
          label,
          required: true,
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          value: value,
          hint: Text(hint),
          items: items,
          onChanged: onChanged,
          decoration: const InputDecoration(),
        ),
      ],
    );
  }

  Widget _label(
      BuildContext context,
      String text, {
        bool required = false,
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