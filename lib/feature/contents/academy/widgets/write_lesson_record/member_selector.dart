import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../notifier/academy_notifier.dart';
import '../../state/academy_form_state.dart';
import 'academy_section_card.dart';

class AcademyMemberSelector extends ConsumerStatefulWidget {
  final AcademyFormState state;

  const AcademyMemberSelector({
    super.key,
    required this.state,
  });

  @override
  ConsumerState<AcademyMemberSelector> createState() =>
      _AcademyMemberSelectorState();
}

class _AcademyMemberSelectorState
    extends ConsumerState<AcademyMemberSelector> {
  final TextEditingController _searchController =
  TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final notifier = ref.read(academyProvider.notifier);

    final keyword = _searchController.text
        .trim()
        .toLowerCase();

    final filteredMembers = state.members.where(
          (member) => member.name
          .toLowerCase()
          .contains(keyword),
    );

    return AcademySectionCard(
      title: '참여 학생',
      icon: Icons.people_outline_rounded,
      trailing: ElevatedButton(
        onPressed: state.members.isEmpty
            ? null
            : notifier.selectAllMembers,
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
            children: filteredMembers.map((member) {
              final selected = state.selectedMembers.any(
                    (element) => element.id == member.id,
              );
              return FilterChip(
                selected: selected,
                label: Text(member.name),
                onSelected: (_) {
                  notifier.toggleMember(member);
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: ConstPadding.smallPadding,
          ),
          Text(
            '총 ${state.selectedMembers.length}명 선택됨',
            style: Theme.of(context)
                .textTheme
                .bodySmall,
          ),
        ],
      ),
    );
  }
}