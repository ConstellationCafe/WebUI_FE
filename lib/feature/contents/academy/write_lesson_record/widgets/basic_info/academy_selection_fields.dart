import 'package:flutter/material.dart';

import '../../state/academy_form_state.dart';

class AcademySelectionFields extends StatelessWidget {
  final AcademyFormState state;

  final ValueChanged<String> onAcademyChanged;
  final ValueChanged<String> onClassChanged;
  final ValueChanged<String> onSubjectChanged;

  const AcademySelectionFields({
    super.key,
    required this.state,
    required this.onAcademyChanged,
    required this.onClassChanged,
    required this.onSubjectChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _dropdown(
            context,
            label: '아카데미 이름',
            hint: '아카데미를 선택하세요',
            value: state.selectedAcademy?.id.toString(),
            items: state.academies
                .map(
                  (academy) => DropdownMenuItem<String>(
                    value: academy.id.toString(),
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
          child: _dropdown(
            context,
            label: '분반',
            hint: '분반을 선택하세요',
            value: state.selectedClass,
            items: state.classes
                .map(
                  (academyClass) => DropdownMenuItem<String>(
                    value: academyClass.id.toString(),
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
          child: _dropdown(
            context,
            label: '과목',
            hint: '과목을 선택하세요',
            value: state.selectedSubject,
            items: state.subjects
                .map(
                  (subject) => DropdownMenuItem<String>(
                    value: subject.id.toString(),
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

  Widget _dropdown(
      BuildContext context, {
        required String label,
        required String hint,
        required String? value,
        required List<DropdownMenuItem<String>> items,
        required ValueChanged<String?> onChanged,
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
        DropdownButtonFormField<String>(
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