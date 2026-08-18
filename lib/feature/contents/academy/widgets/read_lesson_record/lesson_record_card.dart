import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/lesson_record_summary.dart';

class LessonRecordCard extends StatelessWidget {
  final LessonRecordSummary record;

  const LessonRecordCard({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AcademyConstants.cardBorderRadius,
        ),
      ),
      child: Padding(
        padding: ConstPadding.mediumPaddingAll,
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    record.subject,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  _formatDate(record.educationDate),
                  style: textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(
              height: ConstPadding.smallPadding,
            ),
            Text(
              '${record.academyName} · ${record.className}분반',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(
              height: ConstPadding.tinyPadding,
            ),
            Text(
              '담당 교사: ${record.mainTeacherName}',
              style: textTheme.bodySmall,
            ),
            const SizedBox(
              height: ConstPadding.tinyPadding,
            ),
            Text(
              '수업 시간: ${record.educationDuration.inMinutes}분',
              style: textTheme.bodySmall,
            ),
            const SizedBox(
              height: ConstPadding.smallPadding,
            ),
            const Divider(),
            const SizedBox(
              height: ConstPadding.smallPadding,
            ),
            Text(
              record.description.isEmpty
                  ? '작성된 수업 내용이 없습니다.'
                  : record.description,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(
              height: ConstPadding.smallPadding,
            ),
            Row(
              children: [
                const Icon(
                  Icons.people_outline,
                  size: AcademyConstants.memberIconSize,
                ),
                const SizedBox(
                  width: ConstPadding.tinyPadding,
                ),
                Text(
                  '수강자: ${record.memberCount}명',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.day.toString().padLeft(2, '0')}';
  }
}