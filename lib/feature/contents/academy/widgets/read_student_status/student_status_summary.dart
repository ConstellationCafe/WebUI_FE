import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/student_status_list/student_status_list.dart';

import 'student_status_summary_item.dart';

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
          crossAxisAlignment:
          CrossAxisAlignment.start,
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
                StudentStatusSummaryItem(
                  label: '전체',
                  count:
                  studentStatusList.totalCount,
                  icon:
                  Icons.people_outline,
                ),
                StudentStatusSummaryItem(
                  label: '재적',
                  count:
                  studentStatusList.enrolledCount,
                  icon:
                  Icons.school_outlined,
                ),
                StudentStatusSummaryItem(
                  label: '졸업',
                  count: studentStatusList
                      .graduationCount,
                  icon:
                  Icons.workspace_premium_outlined,
                ),
                StudentStatusSummaryItem(
                  label: '퇴학',
                  count:
                  studentStatusList.expulsionCount,
                  icon:
                  Icons.person_remove_outlined,
                ),
                StudentStatusSummaryItem(
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
}