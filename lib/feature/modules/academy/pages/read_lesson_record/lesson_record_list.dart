import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/shared/widgets/breadcrumb/app_breadcrumb.dart';
import 'package:constellation_cafe/shared/widgets/loading/page_loading.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';
import '../../notifier/lesson_record_list_notifier/lesson_record_list_notifier.dart';
import '../../notifier/lesson_record_selection_notifier/lesson_record_selection_notifier.dart';
import '../../widgets/academy_error_banner.dart';
import '../../widgets/read_lesson_record/lesson_record_filter/lesson_record_filter.dart';
import '../../widgets/read_lesson_record/lesson_record_empty_view.dart';
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

    final horizontalPadding = isDesktop
        ? ConstPadding.largePadding
        : ConstPadding.mediumPadding;
    final records = listState.lessonRecordList.records;

    final list = LessonRecordList(
      records: records,
      onUpdate: (record, update) async {
        try {
          await listNotifier.updateRecord(record.id, update);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(AcademyStrings.lessonRecordUpdated)),
            );
          }
        } catch (_) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AcademyStrings.lessonRecordUpdateFailed),
              ),
            );
          }
        }
      },
      onDelete: (record) async {
        try {
          await listNotifier.deleteRecord(record.id);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(AcademyStrings.lessonRecordDeleted)),
            );
          }
        } catch (_) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AcademyStrings.lessonRecordDeleteFailed),
              ),
            );
          }
        }
      },
    );

    // 조회 조건 아래 남은 공간을 채우도록 sliver로 배치한다. 기록이 없으면 빈 상태 안내를
    // 남은 여백의 정가운데에 둔다.
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            ConstPadding.mediumPadding,
            horizontalPadding,
            0,
          ),
          sliver: SliverToBoxAdapter(
            child: _ContentWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBreadcrumb(
                    items: [
                      AcademyStrings.lessonManagement,
                      AcademyStrings.readLessonRecordTitle,
                    ],
                  ),
                  const SizedBox(height: ConstPadding.smallPadding),
                  const LessonRecordHeader(),
                  const SizedBox(height: ConstPadding.mediumPadding),
                  LessonRecordFilter(
                    isLoading: queryState.isLoading,
                    // model
                    academies: queryState.queryForm.academies,
                    classes: queryState.queryForm.classes,
                    subjects: queryState.queryForm.subjects,
                    selectedAcademyId: queryState.queryForm.selectedAcademy?.id,
                    selectedClassId:
                        queryState.queryForm.selectedAcademyClass?.id,
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
                  if (listState.errorMessage != null ||
                      queryState.errorMessage != null) ...[
                    AcademyErrorBanner(onRetry: listNotifier.search),
                    const SizedBox(height: ConstPadding.mediumPadding),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (records.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: LessonRecordEmptyView()),
          )
        else
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              0,
              horizontalPadding,
              ConstPadding.mediumPadding,
            ),
            sliver: SliverToBoxAdapter(child: _ContentWidth(child: list)),
          ),
      ],
    );
  }
}

/// 넓은 화면에서도 본문 최대 너비를 지키고 가운데에 둔다.
class _ContentWidth extends StatelessWidget {
  final Widget child;

  const _ContentWidth({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AcademyConstants.contentMaxWidth,
        ),
        child: child,
      ),
    );
  }
}
