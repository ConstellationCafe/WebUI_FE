import 'package:flutter/material.dart';

import '../../../domain/model/academy_class.dart';


class ClassDropdown extends StatelessWidget {
  final List<AcademyClass> classes;
  final int? selectedClassId;
  final ValueChanged<AcademyClass> onChanged;

  const ClassDropdown({
    super.key,
    required this.classes,
    required this.selectedClassId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      initialValue: selectedClassId,
      decoration: const InputDecoration(
        labelText: '분반',
      ),
      items: [
        const DropdownMenuItem<int?>(
          value: null,
          child: Text('전체'),
        ),
        ...classes.map(
              (academyClass) => DropdownMenuItem<int?>(
            value: academyClass.id,
            child: Text(
              '${academyClass.classNumber}분반',
            ),
          ),
        ),
      ],
      onChanged: classes.isEmpty
          ? null
          : (classId) {
        if (classId == null) {
          return;
        }

        final academyClass = classes.firstWhere(
              (academyClass) =>
          academyClass.id.toString() == classId,
        );

        onChanged(academyClass);
      },
    );
  }
}