import 'package:constellation_cafe/feature/contents/academy/notifier/lesson_record_query_notifier/lesson_record_query_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';

import 'package:constellation_cafe/shared/widgets/loading/PageLoading.dart';

import '../../constants/academy_constants.dart';
import '../../notifier/lesson_record_form_notifier/lesson_record_form_notifier.dart';
import '../../notifier/lesson_record_list_notifier/lesson_record_list_notifier.dart';
import '../../widgets/read_lesson_record/lesson_record_filter/lesson_record_filter.dart';
import '../../widgets/read_lesson_record/lesson_record_header.dart';
import '../../widgets/read_lesson_record/lesson_record_list.dart';

class LessonRecordListPage
    extends ConsumerWidget {
  const LessonRecordListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(lessonRecordListProvider);
    final queryState = ref.watch(lessonRecordQueryProvider);
    final listNotifier = ref.read(lessonRecordListProvider.notifier);
    final queryNotifier = ref.read(lessonRecordQueryProvider.notifier);

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
            maxWidth:
            AcademyConstants.contentMaxWidth,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              LessonRecordHeader(),
              const SizedBox(
                height: ConstPadding.mediumPadding,
              ),
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
              const SizedBox(
                height: ConstPadding.largePadding,
              ),
              LessonRecordList(
                records: listState.lessonRecordList.records,
              ),
            ],
          ),
        ),
      ),
    );
  }
}