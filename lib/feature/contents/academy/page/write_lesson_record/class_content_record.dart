import 'package:constellation_cafe/feature/contents/academy/notifier/lesson_record_selection_notifier/lesson_record_selection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/shared/widgets/loading/PageLoading.dart';

import '../../../../../shared/widgets/breadcrumb/app_breadcrumb.dart';
import '../../constants/academy_constants.dart';
import '../../notifier/lesson_record_form_notifier/lesson_record_form_notifier.dart';
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
    final queryState = ref.watch(lessonRecordSelectionProvider);
    final formState = ref.watch(lessonRecordFormProvider);
    final notifier = ref.read(lessonRecordFormProvider.notifier);

    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = ScreenWidth.isDesktop(width);

    if (queryState.isLoading && queryState.queryForm.academies.isEmpty) {
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

    final queryNotifier = ref.read(lessonRecordSelectionProvider.notifier);
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
              AcademyBasicInfo(
                // model
                academies: queryState.queryForm.academies,
                classes: queryState.queryForm.classes,
                subjects: queryState.queryForm.subjects,
                selectedAcademy: queryState.queryForm.selectedAcademy,
                selectedAcademyClass: queryState.queryForm.selectedAcademyClass,
                selectedSubject: queryState.queryForm.selectedSubject,
                educationDate: queryState.queryForm.educationDate,
                startTime: queryState.queryForm.startTime,
                endTime: queryState.queryForm.endTime,
                // callback
                onAcademyChanged: queryNotifier.selectAcademy,
                onClassChanged: queryNotifier.selectClass,
                onSubjectChanged: queryNotifier.selectSubject,
                onEducationDateChanged: queryNotifier.setEducationDate,
                onStartTimeChanged: queryNotifier.setStartTime,
                onEndTimeChanged: queryNotifier.setEndTime,
              ),
              AcademyTeacherInfo(
                teachers: queryState.queryForm.teachers,
                mainTeacher: queryState.queryForm.mainTeacher,
                selectedCoTeachers: queryState.queryForm.selectedCoTeachers,
                onMainTeacherChanged: queryNotifier.selectMainTeacher,
                onCoTeacherToggle: queryNotifier.toggleCoTeacher,
              ),
              AcademyMemberSelector(
                students: queryState.queryForm.students,
                selectedStudents: queryState.queryForm.selectedStudents,
                onStudentToggle: queryNotifier.toggleStudent,
                onSelectAll: queryNotifier.selectAllStudents,
              ),
              LessonDescription(description: formState.lessonRecordForm.description),
              const SizedBox(height: ConstPadding.mediumPadding),
              LessonRecordBottom(
                isSaving: formState.isSaving,
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