import 'package:constellation_cafe/feature/modules/academy/notifier/lesson_record_selection_notifier/lesson_record_selection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';

import 'package:constellation_cafe/shared/widgets/loading/PageLoading.dart';

import '../../constants/academy_constants.dart';
import '../../notifier/lesson_record_list_notifier/lesson_record_list_notifier.dart';
import '../../widgets/read_lesson_record/lesson_record_filter/lesson_record_filter.dart';
import '../../widgets/read_lesson_record/lesson_record_header.dart';
import '../../widgets/read_lesson_record/lesson_record_list.dart';

class LessonRecordListPage extends ConsumerWidget {
  const LessonRecordListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(lessonRecordListProvider);
    final queryState = ref.watch(lessonRecordSelectionProvider);
    final listNotifier = ref.read(lessonRecordListProvider.notifier);
    final queryNotifier = ref.read(lessonRecordSelectionProvider.notifier);

    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = ScreenWidth.isDesktop(width);

    if (listState.isLoading) {
      return const PageLoading();
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop
            ? ConstPadding.largePadding
            : ConstPadding.mediumPadding,
        vertical: ConstPadding.mediumPadding,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AcademyConstants.contentMaxWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LessonRecordHeader(),
              const SizedBox(height: ConstPadding.mediumPadding),
              LessonRecordFilter(
                isLoading: queryState.isLoading,
                // model
                academies: queryState.queryForm.academies,
                classes: queryState.queryForm.classes,
                subjects: queryState.queryForm.subjects,
                selectedAcademyId: queryState.queryForm.selectedAcademy?.id,
                selectedClassId: queryState.queryForm.selectedAcademyClass?.id,
                selectedSubjectId: queryState.queryForm.selectedSubject?.id,
                selectedDate: queryState.queryForm.educationDate,
                selectedTime: queryState.queryForm.startTime,
                // event
                onAcademyChanged: queryNotifier.selectAcademy,
                onClassChanged: queryNotifier.selectClass,
                onSubjectChanged: queryNotifier.selectSubject,
                onDateChanged: queryNotifier.setEducationDate,
                onTimeChanged: queryNotifier.setStartTime,
                onSearch: listNotifier.search,
                onReset: queryNotifier.resetFilters,
              ),
              const SizedBox(height: ConstPadding.largePadding),
              LessonRecordList(
                records: listState.lessonRecordList.records,
                onUpdate: (record, update) async {
                  try {
                    await listNotifier.updateRecord(record.id, update);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('수업 기록을 수정했습니다.')),
                      );
                    }
                  } catch (_) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('수업 기록 수정에 실패했습니다.')),
                      );
                    }
                  }
                },
                onDelete: (record) async {
                  try {
                    await listNotifier.deleteRecord(record.id);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('수업 기록을 삭제했습니다.')),
                      );
                    }
                  } catch (_) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('수업 기록 삭제에 실패했습니다.')),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
