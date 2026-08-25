import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/student_status_view/student_status_view.dart';
import '../../domain/type/student_roster_status.dart';

class StudentStatusTable extends StatelessWidget {
  final List<StudentStatusView> items;
  final int totalCount;
  final int currentPage;
  final int pageSize;

  const StudentStatusTable({
    super.key,
    required this.items,
    required this.totalCount,
    required this.currentPage,
    required this.pageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: ConstPadding.largePaddingAll,
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.list_alt_outlined,
                ),
                const SizedBox(
                  width: ConstPadding.smallPadding,
                ),
                Text(
                  '학생 명단',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: ConstPadding.largePadding,
            ),
            if (items.isEmpty)
              _emptyView(context)
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: AcademyConstants
                        .studentStatusTableMinWidth,
                  ),
                  child: DataTable(
                    headingRowHeight:
                    AcademyConstants
                        .studentStatusTableHeaderHeight,
                    dataRowMinHeight:
                    AcademyConstants
                        .studentStatusTableRowHeight,
                    dataRowMaxHeight:
                    AcademyConstants
                        .studentStatusTableRowHeight,
                    columnSpacing:
                    AcademyConstants
                        .studentStatusTableColumnSpacing,
                    columns: const [
                      DataColumn(
                        label: Text('번호'),
                      ),
                      DataColumn(
                        label: Text('학생명'),
                      ),
                      DataColumn(
                        label: Text('아카데미'),
                      ),
                      DataColumn(
                        label: Text('분반'),
                      ),
                      DataColumn(
                        label: Text('상태'),
                      ),
                      DataColumn(
                        label: Text('변경일'),
                      ),
                      DataColumn(
                        label: Text('변경 사유'),
                      ),
                    ],
                    rows: List.generate(
                      items.length,
                          (index) {
                        final item = items[index];

                        final number =
                            totalCount -
                                ((currentPage - 1) *
                                    pageSize) -
                                index;

                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                '$number',
                              ),
                            ),
                            DataCell(
                              Text(
                                item.student.name,
                              ),
                            ),
                            DataCell(
                              Text(
                                item.academy.name,
                              ),
                            ),
                            DataCell(
                              Text(
                                '${item.academyClass.classNumber}분반',
                              ),
                            ),
                            DataCell(
                              _statusBadge(
                                context,
                                item.status,
                              ),
                            ),
                            DataCell(
                              Text(
                                _formatDate(
                                  item.changedAt,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                item.reason
                                    ?.trim()
                                    .isNotEmpty ==
                                    true
                                    ? item.reason!
                                    : '-',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _emptyView(BuildContext context) {
    return Center(
      child: Padding(
        padding: ConstPadding.largePaddingAll,
        child: Column(
          children: [
            Icon(
              Icons.person_search_outlined,
              size: AcademyConstants.emptyIconSize,
              color: Theme.of(context)
                  .colorScheme
                  .outline,
            ),
            const SizedBox(
              height: ConstPadding.mediumPadding,
            ),
            Text(
              '조회된 학생이 없습니다.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(
      BuildContext context,
      StudentRosterStatus status,
      ) {
    final theme = Theme.of(context);

    final Color backgroundColor;
    final Color foregroundColor;

    switch (status) {
      case StudentRosterStatus.enrolled:
        backgroundColor =
            theme.colorScheme.primaryContainer;
        foregroundColor =
            theme.colorScheme.onPrimaryContainer;

      case StudentRosterStatus.graduation:
        backgroundColor =
            theme.colorScheme.secondaryContainer;
        foregroundColor =
            theme.colorScheme.onSecondaryContainer;

      case StudentRosterStatus.expulsion:
        backgroundColor =
            theme.colorScheme.errorContainer;
        foregroundColor =
            theme.colorScheme.onErrorContainer;

      case StudentRosterStatus.withdrawal:
        backgroundColor =
            theme.colorScheme.surfaceContainerHighest;
        foregroundColor =
            theme.colorScheme.onSurfaceVariant;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AcademyConstants
            .studentStatusBadgeHorizontalPadding,
        vertical: AcademyConstants
            .studentStatusBadgeVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          AcademyConstants
              .studentStatusBadgeBorderRadius,
        ),
      ),
      child: Text(
        _statusLabel(status),
        style: theme.textTheme.labelMedium?.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _statusLabel(
      StudentRosterStatus status,
      ) {
    switch (status) {
      case StudentRosterStatus.enrolled:
        return '재적';

      case StudentRosterStatus.graduation:
        return '졸업';

      case StudentRosterStatus.expulsion:
        return '퇴학';

      case StudentRosterStatus.withdrawal:
        return '자퇴';
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '-';
    }

    final year = date.year.toString();

    final month =
    date.month.toString().padLeft(2, '0');

    final day =
    date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}