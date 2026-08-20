import 'package:flutter/material.dart';

import '../../../../../core/constants/const_padding.dart';

import '../../state/student_status_state/student_status_state.dart';

class StudentStatusBasicInfo
    extends StatelessWidget {
  final StudentStatusState state;

  final ValueChanged<String> onAcademyChanged;
  final ValueChanged<String> onClassChanged;
  final ValueChanged<String> onStudentChanged;

  const StudentStatusBasicInfo({
    super.key,
    required this.state,
    required this.onAcademyChanged,
    required this.onClassChanged,
    required this.onStudentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          '학생 정보',
          style: Theme.of(context)
              .textTheme
              .titleMedium,
        ),

        const SizedBox(
          height: ConstPadding.mediumPadding,
        ),

        DropdownButtonFormField<String>(
          value: state.selectedAcademyId,
          decoration: const InputDecoration(
            labelText: '아카데미 *',
            hintText: '아카데미를 선택하세요',
          ),
          items: state.academies
              .map(
                (academy) =>
                DropdownMenuItem<String>(
                  value: academy.id,
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

        const SizedBox(
          height: ConstPadding.mediumPadding,
        ),

        DropdownButtonFormField<String>(
          value: state.selectedClassName,
          decoration: const InputDecoration(
            labelText: '분반 *',
            hintText: '분반을 선택하세요',
          ),
          items: state.classes
              .map(
                (classInfo) =>
                DropdownMenuItem<String>(
                  value: classInfo.id.toString(),
                  child: Text("${classInfo.classNumber}분반"),
                ),
          )
              .toList(),
          onChanged: state.selectedAcademyId == null
              ? null
              : (value) {
            if (value != null) {
              onClassChanged(value);
            }
          },
        ),

        const SizedBox(
          height: ConstPadding.mediumPadding,
        ),

        DropdownButtonFormField<String>(
          value: state.selectedStudentId,
          decoration: const InputDecoration(
            labelText: '학생 *',
            hintText: '학생을 선택하세요',
          ),
          items: state.students
              .map(
                (student) =>
                DropdownMenuItem<String>(
                  value: student.id,
                  child: Text(student.name),
                ),
          )
              .toList(),
          onChanged: state.selectedClassName == null
              ? null
              : (value) {
            if (value != null) {
              onStudentChanged(value);
            }
          },
        ),
      ],
    );
  }
}