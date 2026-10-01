import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/feature/modules/academy/constants/academy_strings.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/academy.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/academy_class.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/subject.dart';

import 'academy_labeled_dropdown.dart';

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
          child: AcademyLabeledDropdown<Academy>(
            label: AcademyStrings.academyName,
            hint: AcademyStrings.selectAcademy,
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
        const SizedBox(width: ConstPadding.mediumPadding),
        Expanded(
          child: AcademyLabeledDropdown<AcademyClass>(
            label: AcademyStrings.academyClass,
            hint: AcademyStrings.selectClass,
            value: selectedAcademyClass,
            items: classes
                .map(
                  (academyClass) => DropdownMenuItem<AcademyClass>(
                    value: academyClass,
                    child: Text(
                      AcademyStrings.classNumber(academyClass.classNumber),
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
        const SizedBox(width: ConstPadding.mediumPadding),
        Expanded(
          child: AcademyLabeledDropdown<Subject>(
            label: AcademyStrings.subject,
            hint: AcademyStrings.selectSubject,
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
}
