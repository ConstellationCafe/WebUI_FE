import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';

import 'package:constellation_cafe/shared/widgets/loading/PageLoading.dart';
import '../../constants/academy_constants.dart';
import '../notifier/lesson_record_list_notifier.dart';
import '../widgets/lesson_record_filter.dart';
import '../widgets/lesson_record_list.dart';

class LessonRecordListPage
    extends ConsumerWidget {
  const LessonRecordListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lessonRecordListProvider);
    final notifier = ref.read(
      lessonRecordListProvider.notifier,
    );

    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = ScreenWidth.isDesktop(width);

    if (state.isLoading && state.records.isEmpty) {
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
              _header(context),
              const SizedBox(
                height: ConstPadding.mediumPadding,
              ),
              LessonRecordFilter(
                selectedDate: state.selectedDate,
                selectedTime: state.selectedTime,
                selectedSubject: state.selectedSubject,
                onDateChanged: notifier.setDate,
                onTimeChanged: notifier.setTime,
                onSubjectChanged: notifier.setSubject,
                onSearch: notifier.search,
                onReset: notifier.resetFilters,
              ),
              const SizedBox(
                height: ConstPadding.largePadding,
              ),
              LessonRecordList(
                records: state.records,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          '수업 내용 기록',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(
          height: ConstPadding.tinyPadding,
        ),
        Text(
          '기록한 수업 내용을 조회할 수 있습니다.',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}