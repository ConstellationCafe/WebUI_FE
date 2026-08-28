import 'package:constellation_cafe/feature/contents/academy/domain/type/teacher_status_type.dart';
import 'package:constellation_cafe/shared/widgets/breadcrumb/app_breadcrumb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/shared/widgets/loading/PageLoading.dart';

import '../../constants/academy_constants.dart';
import '../../notifier/teacher_status_notifier/teacher_status_notifier.dart';
import '../../widgets/edit_status/status_actions.dart';
import '../../widgets/edit_status/status_basic_info.dart';
import '../../widgets/edit_status/status_process_form.dart';

class TeacherStatusPage extends ConsumerWidget {
  const TeacherStatusPage({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final state = ref.watch(teacherStatusProvider);

    final notifier = ref.read(
      teacherStatusProvider.notifier,
    );

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
              AppBreadcrumb(items: ['교사 관리', '교사 상태 처리']),
              const SizedBox(
                height: ConstPadding.smallPadding,
              ),
              Text(
                '교사 상태 처리',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium,
              ),
              const SizedBox(
                height: ConstPadding.tinyPadding,
              ),
              Text(
                '교사의 은퇴, 징계 처리를 진행합니다.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium,
              ),
              const SizedBox(
                height: ConstPadding.largePadding,
              ),
              _sectionCard(
                context,
                title: '교사 정보',
                icon: Icons.person_outline,
                child: StatusBasicInfo(
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
              const SizedBox(
                height: ConstPadding.mediumPadding,
              ),
              _sectionCard(
                context,
                title: '처리 정보',
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