import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/shared/widgets/breadcrumb/app_breadcrumb.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';
import '../../domain/model/teacher.dart';
import '../../domain/type/teacher_roster_status.dart';
import '../../notifier/teacher_status_list_notifier/teacher_status_list_notifier.dart';
import '../../widgets/academy_error_banner.dart';
import '../../widgets/read_status/status_pagination.dart';
import '../../widgets/read_status/status_query_form.dart';
import '../../widgets/read_status/status_summary.dart';
import '../../widgets/read_status/status_table.dart';

class ReadTeacherStatusPage extends ConsumerWidget {
  const ReadTeacherStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teacherStatusListProvider);

    final notifier = ref.read(teacherStatusListProvider.notifier);

    final query = state.query;
    final teacherStatusList = state.teacherStatusList;

    final width = MediaQuery.sizeOf(context).width;

    final isDesktop = ScreenWidth.isDesktop(width);

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
                  AcademyStrings.readTeacherStatusTitle,
                ],
              ),

              const SizedBox(height: ConstPadding.smallPadding),

              Text(
                AcademyStrings.readTeacherStatusTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: ConstPadding.tinyPadding),

              Text(
                AcademyStrings.readTeacherStatusDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: ConstPadding.largePadding),

              StatusQueryForm<Teacher, TeacherRosterStatus>(
                academies: query.academies,
                classes: query.classes,
                academyMembers: query.academyMembers,
                statuses: TeacherRosterStatus.values,
                selectedAcademy: query.selectedAcademy,
                selectedAcademyClass: query.selectedAcademyClass,
                selectedAcademyMember: query.selectedAcademyMember,
                selectedStatus: query.selectedStatus,
                memberLabel: AcademyStrings.teacher,
                statusLabel: AcademyStrings.teacherStatus,
                isLoading: state.isFilterLoading,
                onAcademyChanged: notifier.selectAcademy,
                onClassChanged: notifier.selectClass,
                onAcademyMemberChanged: notifier.selectTeacher,
                onStatusChanged: notifier.selectStatus,
                onReset: notifier.resetFilters,
                onSearch: notifier.search,
              ),

              const SizedBox(height: ConstPadding.mediumPadding),

              StatusSummary(
                title: AcademyStrings.teacherSummary,
                items: [
                  StatusSummaryData(
                    label: AcademyStrings.all,
                    count: teacherStatusList.totalCount,
                    icon: Icons.people_outline,
                  ),
                  StatusSummaryData(
                    label: TeacherRosterStatus.enrolled.label,
                    count: teacherStatusList.enrolledCount,
                    icon: Icons.school_outlined,
                  ),
                  StatusSummaryData(
                    label: TeacherRosterStatus.retirement.label,
                    count: teacherStatusList.retirementCount,
                    icon: Icons.person_off_outlined,
                  ),
                  StatusSummaryData(
                    label: TeacherRosterStatus.disciplinary.label,
                    count: teacherStatusList.disciplinaryCount,
                    icon: Icons.gavel_outlined,
                  ),
                ],
              ),

              const SizedBox(height: ConstPadding.mediumPadding),

              if (state.errorMessage != null) ...[
                AcademyErrorBanner(onRetry: notifier.search),
                const SizedBox(height: ConstPadding.mediumPadding),
              ],

              if (state.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                StatusTable<Teacher, TeacherRosterStatus>(
                  items: teacherStatusList.items,
                  totalCount: teacherStatusList.totalCount,
                  currentPage: teacherStatusList.currentPage,
                  pageSize: query.pageSize,
                  title: AcademyStrings.teacherRoster,
                  memberColumnLabel: AcademyStrings.teacherName,
                  emptyMessage: AcademyStrings.noTeachers,
                ),

              const SizedBox(height: ConstPadding.mediumPadding),

              StatusPagination(
                currentPage: teacherStatusList.currentPage,
                totalPages: teacherStatusList.totalPages,
                onPageChanged: notifier.changePage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
