import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/shared/widgets/breadcrumb/app_breadcrumb.dart';

import '../../constants/academy_constants.dart';
import '../../notifier/student_status_list_notifier/student_status_list_notifier.dart';

import '../../widgets/read_student_status/student_status_pagination.dart';
import '../../widgets/read_student_status/student_status_query_form.dart';
import '../../widgets/read_student_status/student_status_summary.dart';
import '../../widgets/read_student_status/student_status_table.dart';

class ReadStudentStatusPage extends ConsumerWidget {
  const ReadStudentStatusPage({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final state = ref.watch(
      studentStatusListProvider,
    );

    final notifier = ref.read(
      studentStatusListProvider.notifier,
    );

    final query = state.query;
    final studentStatusList = state.studentStatusList;

    final width =
        MediaQuery.sizeOf(context).width;

    final isDesktop =
    ScreenWidth.isDesktop(width);

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
              const AppBreadcrumb(
                items: [
                  '학생 관리',
                  '학생 상태 조회',
                ],
              ),
              const SizedBox(
                height: ConstPadding.smallPadding,
              ),
              Text(
                '학생 상태 조회',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium,
              ),
              const SizedBox(
                height: ConstPadding.tinyPadding,
              ),
              Text(
                '학생의 재적, 졸업, 퇴학, 자퇴, 은퇴, 징계 명단을 조회합니다.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium,
              ),
              const SizedBox(
                height: ConstPadding.largePadding,
              ),
              StudentStatusQueryForm(
                academies: query.academies,
                classes: query.classes,
                students: query.students,
                selectedAcademy: query.selectedAcademy,
                selectedAcademyClass: query.selectedAcademyClass,
                selectedStudent: query.selectedStudent,
                selectedStatus: query.selectedStatus,
                isLoading: state.isFilterLoading,
                onAcademyChanged: notifier.selectAcademy,
                onClassChanged: notifier.selectClass,
                onStudentChanged: notifier.selectStudent,
                onStatusChanged: notifier.selectStatus,
                onReset: notifier.resetFilters,
                onSearch: notifier.search,
              ),
              const SizedBox(
                height: ConstPadding.mediumPadding,
              ),
              StudentStatusSummary(
                studentStatusList: studentStatusList,
              ),
              const SizedBox(
                height: ConstPadding.mediumPadding,
              ),
              if (state.isLoading)
                const Center(
                  child:
                  CircularProgressIndicator(),
                )
              else
                StudentStatusTable(
                  items: studentStatusList.items,
                  totalCount: studentStatusList.totalCount,
                  currentPage: studentStatusList.currentPage,
                  pageSize: query.pageSize,
                ),
              const SizedBox(
                height: ConstPadding.mediumPadding,
              ),
              StudentStatusPagination(
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