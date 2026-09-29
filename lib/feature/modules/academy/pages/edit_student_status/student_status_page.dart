import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/shared/widgets/breadcrumb/app_breadcrumb.dart';
import 'package:constellation_cafe/shared/widgets/loading/page_loading.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';
import '../../domain/type/student_status_type.dart';
import '../../notifier/student_status_notifier/student_status_notifier.dart';
import '../../widgets/academy_error_banner.dart';
import '../../widgets/edit_status/status_actions.dart';
import '../../widgets/edit_status/status_basic_info.dart';
import '../../widgets/edit_status/status_process_form.dart';
import '../../widgets/edit_status/status_section_card.dart';

class StudentStatusPage extends ConsumerWidget {
  const StudentStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studentStatusProvider);

    final notifier = ref.read(studentStatusProvider.notifier);

    final width = MediaQuery.sizeOf(context).width;

    final isDesktop = ScreenWidth.isDesktop(width);

    if (state.isLoading && state.studentStatus.academies.isEmpty) {
      return const PageLoading();
    }

    final studentStatus = state.studentStatus;

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
                  AcademyStrings.studentManagement,
                  AcademyStrings.editStudentStatusTitle,
                ],
              ),
              const SizedBox(height: ConstPadding.smallPadding),
              Text(
                AcademyStrings.editStudentStatusTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: ConstPadding.tinyPadding),
              Text(
                AcademyStrings.editStudentStatusDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: ConstPadding.largePadding),
              if (state.errorMessage != null) ...[
                const AcademyErrorBanner(),
                const SizedBox(height: ConstPadding.mediumPadding),
              ],
              StatusSectionCard(
                title: AcademyStrings.studentInfo,
                icon: Icons.person_outline,
                child: StatusBasicInfo(
                  memberLabel: AcademyStrings.student,
                  academies: studentStatus.academies,
                  classes: studentStatus.classes,
                  members: studentStatus.students,
                  selectedAcademy: studentStatus.selectedAcademy,
                  selectedAcademyClass: studentStatus.selectedAcademyClass,
                  selectedMembers: studentStatus.selectedStudent,
                  onAcademyChanged: notifier.selectAcademy,
                  onClassChanged: notifier.selectClass,
                  onMemberChanged: notifier.selectStudent,
                ),
              ),
              const SizedBox(height: ConstPadding.mediumPadding),
              StatusSectionCard(
                title: AcademyStrings.processInfo,
                icon: Icons.assignment_outlined,
                child: StatusProcessForm<StudentStatusType>(
                  statuses: StudentStatusType.values,
                  subjects: studentStatus.subjects,
                  selectedStatusType: studentStatus.selectedStatusType,
                  selectedSubjects: studentStatus.selectedSubjects,
                  reason: studentStatus.reason,
                  onStatusChanged: notifier.selectStatus,
                  onSubjectChanged: notifier.toggleSubject,
                  onReasonChanged: notifier.setReason,

                  showSubjectsWhen: (status) =>
                      status == StudentStatusType.graduation,

                  subjectSectionTitle: AcademyStrings.graduationSubjects,
                  subjectHelperText: AcademyStrings.subjectOptionalHelper,
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
                        content: Text(AcademyStrings.studentStatusProcessed),
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
