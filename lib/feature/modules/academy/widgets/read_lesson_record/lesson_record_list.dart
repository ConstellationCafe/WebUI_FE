import 'package:flutter/material.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/lesson_record/lesson_record_update.dart';
import '../../domain/model/lesson_record/lesson_record_view.dart';
import 'lesson_record_card.dart';
import 'lesson_record_empty_view.dart';

class LessonRecordList extends StatelessWidget {
  final List<LessonRecordView> records;
  final Future<void> Function(LessonRecordView, LessonRecordUpdate) onUpdate;
  final Future<void> Function(LessonRecordView) onDelete;

  const LessonRecordList({
    super.key,
    required this.records,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const LessonRecordEmptyView();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: records.length,
      separatorBuilder: (_, _) =>
          const SizedBox(height: AcademyConstants.recordCardSpacing),
      itemBuilder: (context, index) {
        return LessonRecordCard(
          record: records[index],
          onUpdate: onUpdate,
          onDelete: onDelete,
        );
      },
    );
  }
}
