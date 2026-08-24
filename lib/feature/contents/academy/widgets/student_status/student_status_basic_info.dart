import 'package:flutter/material.dart';

import '../../../../../core/constants/const_padding.dart';

import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/student.dart';

class StudentStatusBasicInfo extends StatelessWidget {
  final List<Academy> academies;
  final List<AcademyClass> classes;
  final List<Student> students;

  final Academy? selectedAcademy;
  final AcademyClass? selectedAcademyClass;
  final Student? selectedStudent;

  final ValueChanged<Academy> onAcademyChanged;
  final ValueChanged<AcademyClass> onClassChanged;
  final ValueChanged<Student> onStudentChanged;

  const StudentStatusBasicInfo({
    super.key,
    required this.academies,
    required this.classes,
    required this.students,
    required this.selectedAcademy,
    required this.selectedAcademyClass,
    required this.selectedStudent,
    required this.onAcademyChanged,
    required this.onClassChanged,
    required this.onStudentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '학생 정보',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: ConstPadding.mediumPadding,
        ),
        DropdownButtonFormField<Academy>(
          value: selectedAcademy,
          decoration: const InputDecoration(
            labelText: '아카데미 *',
            hintText: '아카데미를 선택하세요',
          ),
          items: academies
              .map(
                (academy) => DropdownMenuItem<Academy>(
              value: academy,
              child: Text(academy.name),
            ),
          )
              .toList(),
          onChanged: (academy) {
            if (academy != null) {
              onAcademyChanged(academy);
            }
          },
        ),
        const SizedBox(
          height: ConstPadding.mediumPadding,
        ),
        DropdownButtonFormField<AcademyClass>(
          value: selectedAcademyClass,
          decoration: const InputDecoration(
            labelText: '분반 *',
            hintText: '분반을 선택하세요',
          ),
          items: classes
              .map(
                (academyClass) =>
                DropdownMenuItem<AcademyClass>(
                  value: academyClass,
                  child: Text(
                    '${academyClass.classNumber}분반',
                  ),
                ),
          )
              .toList(),
          onChanged: selectedAcademy == null
              ? null
              : (academyClass) {
            if (academyClass != null) {
              onClassChanged(academyClass);
            }
          },
        ),
        const SizedBox(
          height: ConstPadding.mediumPadding,
        ),
        DropdownButtonFormField<Student>(
          value: selectedStudent,
          decoration: const InputDecoration(
            labelText: '학생 *',
            hintText: '학생을 선택하세요',
          ),
          items: students
              .map(
                (student) => DropdownMenuItem<Student>(
              value: student,
              child: Text(student.name),
            ),
          )
              .toList(),
          onChanged: selectedAcademyClass == null
              ? null
              : (student) {
            if (student != null) {
              onStudentChanged(student);
            }
          },
        ),
      ],
    );
  }
}