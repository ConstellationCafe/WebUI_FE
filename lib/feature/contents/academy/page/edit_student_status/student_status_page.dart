import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/shared/widgets/loading/PageLoading.dart';

import '../../constants/academy_constants.dart';
import '../../domain/type/student_status_type.dart';
import '../../notifier/student_status_notifier/student_status_notifier.dart';
import '../../widgets/edit_status/status_actions.dart';
import '../../widgets/edit_status/status_basic_info.dart';
import '../../widgets/edit_status/status_process_form.dart';

class StudentStatusPage extends ConsumerWidget {
  const StudentStatusPage({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final state = ref.watch(studentStatusProvider);

    final notifier = ref.read(
      studentStatusProvider.notifier,
    );

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
              _breadcrumb(context),
              const SizedBox(
                height: ConstPadding.smallPadding,
              ),
              Text(
                '학생 상태 처리',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium,
              ),
              const SizedBox(
                height: ConstPadding.tinyPadding,
              ),
              Text(
                '학생의 졸업, 퇴학, 자퇴 처리를 진행합니다.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium,
              ),
              const SizedBox(
                height: ConstPadding.largePadding,
              ),
              _sectionCard(
                context,
                title: '학생 정보',
                icon: Icons.person_outline,
                child: StatusBasicInfo(
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
              const SizedBox(
                height: ConstPadding.mediumPadding,
              ),
              _sectionCard(
                context,
                title: '처리 정보',
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

                  subjectSectionTitle: '졸업 교과목',
                  subjectHelperText: '교과목은 선택하지 않아도 됩니다.',
                ),
              ),
              const SizedBox(
                height: ConstPadding.mediumPadding,
              ),
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
                        content: Text(
                          '학생 상태 처리가 완료되었습니다.',
                        ),
                      ),
                    );

                    context.pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          '필수 항목을 확인해주세요.',
                        ),
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

  Widget _breadcrumb(
      BuildContext context,
      ) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(
          '학생 관리',
          style: textTheme.bodySmall,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AcademyConstants
                .breadcrumbIconHorizontalPadding,
          ),
          child: Icon(
            Icons.chevron_right,
            size: AcademyConstants.breadcrumbIconSize,
          ),
        ),
        Text(
          '학생 상태 처리',
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _sectionCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required Widget child,
      }) {
    return Card(
      child: Padding(
        padding: ConstPadding.largePaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(
                  width: ConstPadding.smallPadding,
                ),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: ConstPadding.mediumPadding,
            ),
            child,
          ],
        ),
      ),
    );
  }
}