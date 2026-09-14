import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/academy_member.dart';
import '../../domain/type/roster_status.dart';

class StatusQueryForm<
TMember extends AcademyMember,
TStatus extends RosterStatus
> extends StatelessWidget {
  final List<Academy> academies;
  final List<AcademyClass> classes;
  final List<TMember> academyMembers;
  final List<TStatus> statuses;

  final Academy? selectedAcademy;
  final AcademyClass? selectedAcademyClass;
  final TMember? selectedAcademyMember;
  final TStatus? selectedStatus;

  final String memberLabel;
  final String statusLabel;

  final bool isLoading;

  final ValueChanged<Academy?> onAcademyChanged;
  final ValueChanged<AcademyClass?> onClassChanged;
  final ValueChanged<TMember?> onAcademyMemberChanged;
  final ValueChanged<TStatus?> onStatusChanged;

  final VoidCallback onReset;
  final VoidCallback onSearch;

  const StatusQueryForm({
    super.key,
    required this.academies,
    required this.classes,
    required this.academyMembers,
    required this.statuses,
    required this.selectedAcademy,
    required this.selectedAcademyClass,
    required this.selectedAcademyMember,
    required this.selectedStatus,
    required this.memberLabel,
    required this.statusLabel,
    required this.isLoading,
    required this.onAcademyChanged,
    required this.onClassChanged,
    required this.onAcademyMemberChanged,
    required this.onStatusChanged,
    required this.onReset,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: ConstPadding.largePaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.filter_alt_outlined,
                ),
                const SizedBox(
                  width: ConstPadding.smallPadding,
                ),
                Text(
                  '조회 조건',
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),

            const SizedBox(
              height: ConstPadding.largePadding,
            ),

            Wrap(
              spacing:
              AcademyConstants.statusFilterSpacing,
              runSpacing:
              AcademyConstants.statusFilterRunSpacing,
              children: [
                SizedBox(
                  width:
                  AcademyConstants.statusFilterFieldWidth,
                  child: DropdownButtonFormField<Academy?>(
                    value: selectedAcademy,
                    decoration: const InputDecoration(
                      labelText: '아카데미',
                    ),
                    items: [
                      const DropdownMenuItem<Academy?>(
                        value: null,
                        child: Text(
                          '전체 아카데미',
                        ),
                      ),
                      ...academies.map(
                            (academy) =>
                            DropdownMenuItem<Academy?>(
                              value: academy,
                              child: Text(
                                academy.name,
                              ),
                            ),
                      ),
                    ],
                    onChanged: isLoading
                        ? null
                        : onAcademyChanged,
                  ),
                ),

                SizedBox(
                  width:
                  AcademyConstants.statusFilterFieldWidth,
                  child:
                  DropdownButtonFormField<AcademyClass?>(
                    value: selectedAcademyClass,
                    decoration: const InputDecoration(
                      labelText: '분반',
                    ),
                    items: [
                      const DropdownMenuItem<
                          AcademyClass?>(
                        value: null,
                        child: Text(
                          '전체 분반',
                        ),
                      ),
                      ...classes.map(
                            (academyClass) =>
                            DropdownMenuItem<
                                AcademyClass?>(
                              value: academyClass,
                              child: Text(
                                '${academyClass.classNumber}분반',
                              ),
                            ),
                      ),
                    ],
                    onChanged:
                    selectedAcademy == null ||
                        isLoading
                        ? null
                        : onClassChanged,
                  ),
                ),

                SizedBox(
                  width:
                  AcademyConstants.statusFilterFieldWidth,
                  child:
                  DropdownButtonFormField<TMember?>(
                    value: selectedAcademyMember,
                    decoration: InputDecoration(
                      labelText: memberLabel,
                    ),
                    items: [
                      DropdownMenuItem<TMember?>(
                        value: null,
                        child: Text(
                          '전체 $memberLabel',
                        ),
                      ),
                      ...academyMembers.map(
                            (academyMember) =>
                            DropdownMenuItem<TMember?>(
                              value: academyMember,
                              child: Text(
                                academyMember.name,
                              ),
                            ),
                      ),
                    ],
                    onChanged:
                    selectedAcademyClass == null ||
                        isLoading
                        ? null
                        : onAcademyMemberChanged,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: ConstPadding.largePadding,
            ),

            Text(
              statusLabel,
              style: theme.textTheme.labelLarge,
            ),

            const SizedBox(
              height: ConstPadding.smallPadding,
            ),

            Wrap(
              spacing:
              AcademyConstants.statusFilterSpacing,
              runSpacing:
              AcademyConstants.statusFilterRunSpacing,
              children: [
                ChoiceChip(
                  label: const Text(
                    '전체',
                  ),
                  selected:
                  selectedStatus == null,
                  onSelected: isLoading
                      ? null
                      : (_) {
                    onStatusChanged(null);
                  },
                ),

                ...statuses.map(
                      (status) => ChoiceChip(
                    label: Text(
                      status.label,
                    ),
                    selected:
                    selectedStatus == status,
                    onSelected: isLoading
                        ? null
                        : (_) {
                      onStatusChanged(
                        status,
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: ConstPadding.largePadding,
            ),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                    theme.colorScheme.secondary,
                    side: BorderSide(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  onPressed:
                  isLoading
                      ? null
                      : onReset,
                  icon: const Icon(
                    Icons.refresh,
                  ),
                  label: const Text(
                    '초기화',
                  ),
                ),

                const SizedBox(
                  width: ConstPadding.smallPadding,
                ),

                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                    theme.colorScheme.secondary,
                    side: BorderSide(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  onPressed:
                  isLoading
                      ? null
                      : onSearch,
                  icon: isLoading
                      ? const SizedBox(
                    width: AcademyConstants
                        .savingIndicatorSize,
                    height: AcademyConstants
                        .savingIndicatorSize,
                    child:
                    CircularProgressIndicator(
                      strokeWidth:
                      AcademyConstants
                          .savingIndicatorStrokeWidth,
                    ),
                  )
                      : const Icon(
                    Icons.search,
                  ),
                  label: const Text(
                    '조회',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}