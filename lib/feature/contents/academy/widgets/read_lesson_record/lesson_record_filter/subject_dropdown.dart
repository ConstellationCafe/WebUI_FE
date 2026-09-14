import 'package:flutter/material.dart';

import '../../../domain/model/subject.dart';



class SubjectDropdown extends StatelessWidget {
  final List<Subject> subjects;
  final int? selectedSubjectId;
  final ValueChanged<Subject> onChanged;

  const SubjectDropdown({
    super.key,
    required this.subjects,
    required this.selectedSubjectId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      initialValue: selectedSubjectId,
      decoration: const InputDecoration(
        labelText: '과목',
      ),
      items: [
        const DropdownMenuItem<int?>(
          value: null,
          child: Text('전체'),
        ),
        ...subjects.map(
              (subject) => DropdownMenuItem<int?>(
            value: subject.id,
            child: Text(subject.name),
          ),
        ),
      ],
      onChanged: subjects.isEmpty
          ? null
          : (subjectId) {
        if (subjectId == null) {
          return;
        }

        final subject = subjects.firstWhere(
              (subject) =>
          subject.id.toString() == subjectId,
        );

        onChanged(subject);
      },
    );
  }
}