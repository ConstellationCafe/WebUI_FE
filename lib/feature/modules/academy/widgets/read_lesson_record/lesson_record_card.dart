import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';
import '../../domain/model/lesson_record/lesson_record_update.dart';
import '../../domain/model/lesson_record/lesson_record_view.dart';
import '../../domain/model/lesson_record/lesson_time_range.dart';
import 'lesson_record_delete_dialog.dart';
import 'lesson_record_edit_dialog.dart';

class LessonRecordCard extends StatelessWidget {
  final LessonRecordView record;
  final Future<void> Function(LessonRecordView, LessonRecordUpdate) onUpdate;
  final Future<void> Function(LessonRecordView) onDelete;

  const LessonRecordCard({
    super.key,
    required this.record,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AcademyConstants.cardBorderRadius),
      ),
      child: Padding(
        padding: ConstPadding.mediumPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    record.subjectName,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  AcademyStrings.formatCompactDate(record.educationDate),
                  style: textTheme.bodySmall,
                ),
                if (record.canModify) ...[
                  IconButton(
                    tooltip: AcademyStrings.editLessonRecord,
                    onPressed: () => _editRecord(context),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    tooltip: AcademyStrings.deleteLessonRecord,
                    onPressed: () => _confirmDelete(context),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ],
            ),
            const SizedBox(height: ConstPadding.smallPadding),
            Text(
              AcademyStrings.academyAndClass(
                record.academyName,
                record.className,
              ),
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: ConstPadding.tinyPadding),
            Text(
              AcademyStrings.mainTeacherInfo(record.mainTeacherName),
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: ConstPadding.tinyPadding),
            Text(
              AcademyStrings.lessonTimeInfo(
                _formatTimeRange(record),
                record.educationDuration.inMinutes,
              ),
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: ConstPadding.smallPadding),
            const Divider(),
            const SizedBox(height: ConstPadding.smallPadding),
            Text(
              record.description.isEmpty
                  ? AcademyStrings.noLessonDescription
                  : record.description,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: ConstPadding.smallPadding),
            Row(
              children: [
                const Icon(
                  Icons.people_outline,
                  size: AcademyConstants.memberIconSize,
                ),
                const SizedBox(width: ConstPadding.tinyPadding),
                Text(
                  AcademyStrings.memberCountInfo(record.memberCount),
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editRecord(BuildContext context) async {
    final update = await showDialog<LessonRecordUpdate>(
      context: context,
      builder: (_) => LessonRecordEditDialog(record: record),
    );
    if (update != null) {
      await onUpdate(record, update);
    }
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const LessonRecordDeleteDialog(),
    );
    if (confirmed == true) {
      await onDelete(record);
    }
  }

  String _formatTimeRange(LessonRecordView record) {
    if (record.startTime == null || record.endTime == null) {
      return AcademyStrings.timeRange(
        AcademyStrings.emptyTime,
        AcademyStrings.emptyTime,
      );
    }
    final end = AcademyStrings.formatTime(record.endTime!);
    return AcademyStrings.timeRange(
      AcademyStrings.formatTime(record.startTime!),
      LessonTimeRange.endsNextDay(record.startTime!, record.endTime!)
          ? AcademyStrings.nextDayTime(end)
          : end,
    );
  }
}
