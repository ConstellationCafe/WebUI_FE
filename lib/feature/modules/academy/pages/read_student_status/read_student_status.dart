import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/shared/widgets/breadcrumb/app_breadcrumb.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';
import '../../domain/model/student.dart';
import '../../domain/type/student_roster_status.dart';
import '../../notifier/student_status_list_notifier/student_status_list_notifier.dart';
import '../../widgets/academy_error_banner.dart';
import '../../widgets/read_status/status_pagination.dart';
import '../../widgets/read_status/status_query_form.dart';
import '../../widgets/read_status/status_summary.dart';
import '../../widgets/read_status/status_table.dart';

class ReadStudentStatusPage extends ConsumerWidget {
  const ReadStudentStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studentStatusListProvider);

    final notifier = ref.read(studentStatusListProvider.notifier);

    final query = state.query;
    final studentStatusList = state.studentStatusList;

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
                  AcademyStrings.studentManagement,
                  AcademyStrings.readStudentStatusTitle,
                ],
              ),

              const SizedBox(height: ConstPadding.smallPadding),

              Text(
                AcademyStrings.readStudentStatusTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: ConstPadding.tinyPadding),

              Text(
                AcademyStrings.readStudentStatusDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: ConstPadding.largePadding),

              StatusQueryForm<Student, StudentRosterStatus>(
                academies: query.academies,
                classes: query.classes,
                academyMembers: query.academyMembers,
                statuses: StudentRosterStatus.values,
                selectedAcademy: query.selectedAcademy,
                selectedAcademyClass: query.selectedAcademyClass,
                selectedAcademyMember: query.selectedAcademyMember,
                selectedStatus: query.selectedStatus,
                memberLabel: AcademyStrings.student,
                statusLabel: AcademyStrings.studentStatus,
                isLoading: state.isFilterLoading,
                onAcademyChanged: notifier.selectAcademy,
                onClassChanged: notifier.selectClass,
                onAcademyMemberChanged: notifier.selectStudent,
                onStatusChanged: notifier.selectStatus,
                onReset: notifier.resetFilters,
                onSearch: notifier.search,
              ),

              const SizedBox(height: ConstPadding.mediumPadding),

              StatusSummary(
                title: AcademyStrings.studentSummary,
                items: [
                  StatusSummaryData(
                    label: AcademyStrings.all,
                    count: studentStatusList.totalCount,
                    icon: Icons.people_outline,
                  ),
                  StatusSummaryData(
                    label: StudentRosterStatus.enrolled.label,
                    count: studentStatusList.enrolledCount,
                    icon: Icons.school_outlined,
                  ),
                  StatusSummaryData(
                    label: StudentRosterStatus.graduation.label,
                    count: studentStatusList.graduationCount,
                    icon: Icons.workspace_premium_outlined,
                  ),
                  StatusSummaryData(
                    label: StudentRosterStatus.expulsion.label,
                    count: studentStatusList.expulsionCount,
                    icon: Icons.person_remove_outlined,
                  ),
                  StatusSummaryData(
                    label: StudentRosterStatus.withdrawal.label,
                    count: studentStatusList.withdrawalCount,
                    icon: Icons.logout_outlined,
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
                StatusTable<Student, StudentRosterStatus>(
                  items: studentStatusList.items,
                  totalCount: studentStatusList.totalCount,
                  currentPage: studentStatusList.currentPage,
                  pageSize: query.pageSize,
                  title: AcademyStrings.studentRoster,
                  memberColumnLabel: AcademyStrings.studentName,
                  emptyMessage: AcademyStrings.noStudents,
                ),

              const SizedBox(height: ConstPadding.mediumPadding),

              StatusPagination(
                currentPage: studentStatusList.currentPage,
                totalPages: studentStatusList.totalPages,
                onPageChanged: notifier.changePage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
