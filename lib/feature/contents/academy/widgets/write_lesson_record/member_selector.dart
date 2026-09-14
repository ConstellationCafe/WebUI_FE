import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/student.dart';
import 'academy_section_card.dart';

class AcademyMemberSelector extends StatefulWidget {
  final List<Student> students;
  final List<Student> selectedStudents;

  final ValueChanged<Student> onStudentToggle;
  final VoidCallback onSelectAll;

  const AcademyMemberSelector({
    super.key,
    required this.students,
    required this.selectedStudents,
    required this.onStudentToggle,
    required this.onSelectAll,
  });

  @override
  State<AcademyMemberSelector> createState() =>
      _AcademyMemberSelectorState();
}

class _AcademyMemberSelectorState
    extends State<AcademyMemberSelector> {
  final TextEditingController _searchController =
  TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyword = _searchController.text.trim().toLowerCase();

    final filteredStudents = widget.students.where(
          (student) => student.name.toLowerCase().contains(keyword),
    );

    return AcademySectionCard(
      title: '참여 학생',
      icon: Icons.people_outline_rounded,
      trailing: ElevatedButton(
        onPressed: widget.students.isEmpty
            ? null
            : widget.onSelectAll,
        child: const Text('전체 선택'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              hintText: '멤버 이름을 검색하세요',
              prefixIcon: Icon(
                Icons.search,
              ),
            ),
          ),
          const SizedBox(
            height: ConstPadding.smallPadding,
          ),
          Wrap(
            spacing: AcademyConstants.memberChipSpacing,
            runSpacing: AcademyConstants.memberChipRunSpacing,
            children: filteredStudents.map((student) {
              final selected = widget.selectedStudents.any(
                    (element) => element.sk == student.sk,
              );

              return FilterChip(
                selected: selected,
                label: Text(student.name),
                onSelected: (_) {
                  widget.onStudentToggle(student);
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: ConstPadding.smallPadding,
          ),
          Text(
            '총 ${widget.selectedStudents.length}명 선택됨',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}