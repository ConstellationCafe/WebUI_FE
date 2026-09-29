import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_strings.dart';
import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/academy_member.dart';

class StatusBasicInfo<T extends AcademyMember> extends StatelessWidget {
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
          AcademyStrings.memberInfo(memberLabel),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: ConstPadding.mediumPadding),
        DropdownButtonFormField<Academy>(
          // 선택 값은 notifier state가 소유하므로 controlled value를 유지한다.
          // ignore: deprecated_member_use
          value: selectedAcademy,
          decoration: const InputDecoration(
            labelText: AcademyStrings.academyRequired,
            hintText: AcademyStrings.selectAcademy,
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
        const SizedBox(height: ConstPadding.mediumPadding),
        DropdownButtonFormField<AcademyClass>(
          // ignore: deprecated_member_use
          value: selectedAcademyClass,
          decoration: const InputDecoration(
            labelText: AcademyStrings.classRequired,
            hintText: AcademyStrings.selectClass,
          ),
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
          onChanged: classes.isEmpty
              ? null
              : (academyClass) {
                  if (academyClass != null) {
                    onClassChanged(academyClass);
                  }
                },
        ),
        const SizedBox(height: ConstPadding.mediumPadding),
        DropdownButtonFormField<T>(
          // ignore: deprecated_member_use
          value: selectedMembers,
          decoration: InputDecoration(
            labelText: AcademyStrings.requiredLabel(memberLabel),
            hintText: AcademyStrings.selectMember(memberLabel),
          ),
          items: members
              .map(
                (member) => DropdownMenuItem<T>(
                  value: member,
                  child: Text(member.name),
                ),
              )
              .toList(),
          onChanged: members.isEmpty
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
