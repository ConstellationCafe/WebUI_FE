import 'package:flutter/material.dart';

import '../../../../../core/constants/const_padding.dart';

import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/academy_member.dart';

class StatusBasicInfo<T extends AcademyMember>
    extends StatelessWidget {
  final String memberLabel;

  final List<Academy> academies;
  final List<AcademyClass> classes;
  final List<T> members;

  final Academy? selectedAcademy;
  final AcademyClass? selectedAcademyClass;
  final T? selectedMembers;

  final ValueChanged<Academy> onAcademyChanged;
  final ValueChanged<AcademyClass> onClassChanged;
  final ValueChanged<T> onMemberChanged;

  const StatusBasicInfo({
    super.key,
    required this.memberLabel,
    required this.academies,
    required this.classes,
    required this.members,
    required this.selectedAcademy,
    required this.selectedAcademyClass,
    required this.selectedMembers,
    required this.onAcademyChanged,
    required this.onClassChanged,
    required this.onMemberChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$memberLabel 정보',
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
        DropdownButtonFormField<T>(
          value: selectedMembers,
          decoration: InputDecoration(
            labelText: '$memberLabel *',
            hintText: '$memberLabel을 선택하세요',
          ),
          items: members
            .map(
              (member) => DropdownMenuItem<T>(
                value: member,
                child: Text(member.name),
            ),
          )
              .toList(),
          onChanged: selectedAcademyClass == null
              ? null
              : (student) {
            if (student != null) {
              onMemberChanged(student);
            }
          },
        ),
      ],
    );
  }
}