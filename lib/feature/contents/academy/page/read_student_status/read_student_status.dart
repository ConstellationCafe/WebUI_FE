import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/shared/widgets/breadcrumb/app_breadcrumb.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/student.dart';
import '../../domain/model/student_status_list/student_status_list.dart';
import '../../domain/model/student_status_query/student_status_query.dart';
import '../../domain/type/student_roster_status.dart';
import '../../widgets/read_student_status/student_status_pagination.dart';
import '../../widgets/read_student_status/student_status_query_form.dart';
import '../../widgets/read_student_status/student_status_summary.dart';
import '../../widgets/read_student_status/student_status_table.dart';


class ReadStudentStatusPage extends StatelessWidget {
  final StudentStatusQuery query;
  final StudentStatusList studentStatusList;
  final bool isLoading;
  final bool isFilterLoading;

  final ValueChanged<Academy?> onAcademyChanged;
  final ValueChanged<AcademyClass?> onClassChanged;
  final ValueChanged<Student?> onStudentChanged;
  final ValueChanged<StudentRosterStatus?> onStatusChanged;
  final ValueChanged<int> onPageChanged;

  final VoidCallback onReset;
  final VoidCallback onSearch;

  const ReadStudentStatusPage({
    super.key,
    required this.query,
    required this.studentStatusList,
    required this.isLoading,
    required this.isFilterLoading,
    required this.onAcademyChanged,
    required this.onClassChanged,
    required this.onStudentChanged,
    required this.onStatusChanged,
    required this.onReset,
    required this.onSearch,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
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
            maxWidth:
            AcademyConstants.contentMaxWidth,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              AppBreadcrumb(
                items: const [
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
                '학생의 재적, 졸업, 퇴학, 자퇴 명단을 조회합니다.',
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

                isLoading: isFilterLoading,

                onAcademyChanged: onAcademyChanged,
                onClassChanged: onClassChanged,
                onStudentChanged: onStudentChanged,
                onStatusChanged: onStatusChanged,
                onReset: onReset,
                onSearch: onSearch,
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
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
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
                onPageChanged: onPageChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}