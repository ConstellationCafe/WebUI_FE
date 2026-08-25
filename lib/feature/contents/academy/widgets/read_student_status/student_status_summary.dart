import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/student_status_list/student_status_list.dart';

class StudentStatusSummary extends StatelessWidget {
  final StudentStatusList studentStatusList;

  const StudentStatusSummary({
    super.key,
    required this.studentStatusList,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: ConstPadding.largePaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.groups_outlined,
                ),
                const SizedBox(
                  width: ConstPadding.smallPadding,
                ),
                Text(
                  '학생 현황',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: ConstPadding.largePadding,
            ),
            Wrap(
              spacing: AcademyConstants
                  .studentStatusSummarySpacing,
              runSpacing: AcademyConstants
                  .studentStatusSummaryRunSpacing,
              children: [
                _summaryItem(
                  context,
                  label: '전체',
                  count:
                  studentStatusList.totalCount,
                  icon: Icons.people_outline,
                ),
                _summaryItem(
                  context,
                  label: '재적',
                  count:
                  studentStatusList.enrolledCount,
                  icon:
                  Icons.school_outlined,
                ),
                _summaryItem(
                  context,
                  label: '졸업',
                  count: studentStatusList
                      .graduationCount,
                  icon:
                  Icons.workspace_premium_outlined,
                ),
                _summaryItem(
                  context,
                  label: '퇴학',
                  count:
                  studentStatusList.expulsionCount,
                  icon:
                  Icons.person_remove_outlined,
                ),
                _summaryItem(
                  context,
                  label: '자퇴',
                  count: studentStatusList
                      .withdrawalCount,
                  icon:
                  Icons.logout_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryItem(
      BuildContext context, {
        required String label,
        required int count,
        required IconData icon,
      }) {
    final theme = Theme.of(context);

    return Container(
      width: AcademyConstants
          .studentStatusSummaryItemWidth,
      padding: ConstPadding.mediumPaddingAll,
      decoration: BoxDecoration(
        color:
        theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(
          AcademyConstants.cardBorderRadius,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(
            width: ConstPadding.mediumPadding,
          ),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:
                theme.textTheme.bodyMedium,
              ),
              const SizedBox(
                height: ConstPadding.tinyPadding,
              ),
              Text(
                '$count명',
                style: theme.textTheme.titleLarge
                    ?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}