import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/lesson_record_view.dart';
import '../../domain/model/lesson_record_update.dart';
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
                  _formatDate(record.educationDate),
                  style: textTheme.bodySmall,
                ),
                if (record.canModify) ...[
                  IconButton(
                    tooltip: '수업 기록 수정',
                    onPressed: () => _editRecord(context),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    tooltip: '수업 기록 삭제',
                    onPressed: () => _confirmDelete(context),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ],
            ),
            const SizedBox(height: ConstPadding.smallPadding),
            Text(
              '${record.academyName} · ${record.className}분반',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: ConstPadding.tinyPadding),
            Text(
              '담당 교사: ${record.mainTeacherName}',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: ConstPadding.tinyPadding),
            Text(
              '수업 시간: ${_formatTimeRange(record)} · '
              '${record.educationDuration.inMinutes}분',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: ConstPadding.smallPadding),
            const Divider(),
            const SizedBox(height: ConstPadding.smallPadding),
            Text(
              record.description.isEmpty
                  ? '작성된 수업 내용이 없습니다.'
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
                Text('수강자: ${record.memberCount}명', style: textTheme.bodySmall),
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
      builder: (dialogContext) => AlertDialog(
        title: const Text('수업 기록 삭제'),
        content: const Text('이 수업 기록을 삭제할까요? 삭제한 기록은 복구할 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await onDelete(record);
    }
  }

  String _formatTimeRange(LessonRecordView record) {
    if (record.startTime == null || record.endTime == null) {
      return '--:-- ~ --:--';
    }
    return '${_formatTime(record.startTime!)} ~ '
        '${_formatTime(record.endTime!)}';
  }

  String _formatTime(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:'
      '${time.minute.toString().padLeft(2, '0')}';

  String _formatDate(DateTime date) {
    return '${date.year}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.day.toString().padLeft(2, '0')}';
  }
}
