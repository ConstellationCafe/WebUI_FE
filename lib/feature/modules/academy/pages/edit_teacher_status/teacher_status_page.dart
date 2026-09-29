import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/type/teacher_status_type.dart';
import 'package:constellation_cafe/shared/widgets/breadcrumb/app_breadcrumb.dart';
import 'package:constellation_cafe/shared/widgets/loading/page_loading.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';
import '../../notifier/teacher_status_notifier/teacher_status_notifier.dart';
import '../../widgets/academy_error_banner.dart';
import '../../widgets/edit_status/status_actions.dart';
import '../../widgets/edit_status/status_basic_info.dart';
import '../../widgets/edit_status/status_process_form.dart';
import '../../widgets/edit_status/status_section_card.dart';

class TeacherStatusPage extends ConsumerWidget {
  const TeacherStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teacherStatusProvider);

    final notifier = ref.read(teacherStatusProvider.notifier);

    final width = MediaQuery.sizeOf(context).width;

    final isDesktop = ScreenWidth.isDesktop(width);

    if (state.isLoading && state.teacherStatus.academies.isEmpty) {
      return const PageLoading();
    }

    final teacherStatus = state.teacherStatus;

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
              const AppBreadcrumb(
                items: [
                  AcademyStrings.teacherManagement,
                  AcademyStrings.editTeacherStatusTitle,
                ],
              ),
              const SizedBox(height: ConstPadding.smallPadding),
              Text(
                AcademyStrings.editTeacherStatusTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: ConstPadding.tinyPadding),
              Text(
                AcademyStrings.editTeacherStatusDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: ConstPadding.largePadding),
              if (state.errorMessage != null) ...[
                const AcademyErrorBanner(),
                const SizedBox(height: ConstPadding.mediumPadding),
              ],
              StatusSectionCard(
                title: AcademyStrings.teacherInfo,
                icon: Icons.person_outline,
                child: StatusBasicInfo(
                  memberLabel: AcademyStrings.teacher,
                  academies: teacherStatus.academies,
                  classes: teacherStatus.classes,
                  members: teacherStatus.teachers,
                  selectedAcademy: teacherStatus.selectedAcademy,
                  selectedAcademyClass: teacherStatus.selectedAcademyClass,
                  selectedMembers: teacherStatus.selectedTeacher,
                  onAcademyChanged: notifier.selectAcademy,
                  onClassChanged: notifier.selectClass,
                  onMemberChanged: notifier.selectTeacher,
                ),
              ),
              const SizedBox(height: ConstPadding.mediumPadding),
              StatusSectionCard(
                title: AcademyStrings.processInfo,
                icon: Icons.assignment_outlined,
                child: StatusProcessForm<TeacherStatusType>(
                  statuses: TeacherStatusType.values,
                  subjects: const [],
                  selectedStatusType: teacherStatus.selectedStatusType,
                  selectedSubjects: const [],
                  reason: teacherStatus.reason,
                  onStatusChanged: notifier.selectStatus,
                  onSubjectChanged: (_) {},
                  onReasonChanged: notifier.setReason,
                ),
              ),
              const SizedBox(height: ConstPadding.mediumPadding),
              StatusActions(
                isProcessing: state.isProcessing,
                onCancel: context.pop,
                onProcess: () async {
                  final success = await notifier.process();

                  if (!context.mounted) {
                    return;
                  }

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(AcademyStrings.teacherStatusProcessed),
                      ),
                    );

                    context.pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(AcademyStrings.checkRequiredFields),
                      ),
                    );
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
