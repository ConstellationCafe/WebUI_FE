import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/shared/widgets/loading/PageLoading.dart';

import '../../../../../shared/widgets/breadcrumb/app_breadcrumb.dart';
import '../../constants/academy_constants.dart';
import '../../notifier/academy_notifier.dart';
import '../../widgets/write_lesson_record/basic_info/academy_basic_info.dart';
import '../../widgets/write_lesson_record/lesson_description.dart';
import '../../widgets/write_lesson_record/lesson_record_bottom.dart';
import '../../widgets/write_lesson_record/lesson_record_header.dart';
import '../../widgets/write_lesson_record/member_selector.dart';
import '../../widgets/write_lesson_record/teacher_info/academy_teacher_info.dart';


class LessonRecordPage extends ConsumerWidget {
  const LessonRecordPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(academyProvider);
    final notifier = ref.read(academyProvider.notifier);

    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = ScreenWidth.isDesktop(width);

    if (state.isLoading && state.academies.isEmpty) {
      return const PageLoading();
    }

    Future<void> saveLesson() async {
      final success = await notifier.saveLessonRecord();

      if (!context.mounted) {
        return;
      }

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('수업 기록이 저장되었습니다.'),
          ),
        );

        context.pop();
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('필수 항목을 확인해주세요.'),
        ),
      );
    }

    void cancel() {
      context.pop();
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
              AppBreadcrumb(
                items: [
                  '수업 관리',
                  '수업 내용 기록',
                ],
              ),
              const SizedBox(height: ConstPadding.smallPadding),
              LessonRecordHeader(
                isDesktop: isDesktop,
              ),
              const SizedBox(height: ConstPadding.mediumPadding),
              AcademyBasicInfo(state: state),
              AcademyTeacherInfo(state: state),
              AcademyMemberSelector(state: state),
              LessonDescription(description: state.description),
              const SizedBox(height: ConstPadding.mediumPadding),
              LessonRecordBottom(
                isSaving: state.isSaving,
                onSave: saveLesson,
                onCancel: cancel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}