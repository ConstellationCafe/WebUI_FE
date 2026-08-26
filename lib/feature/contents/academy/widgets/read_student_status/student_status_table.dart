import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/utils/date_formatter.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/student_status_view/student_status_view.dart';

import 'student_status_badge.dart';
import 'student_status_empty_view.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
              const StudentStatusEmptyView()
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
                              StudentStatusBadge(
                                status: item.status,
                              ),
                            ),
                            DataCell(
                              Text(
                                DateFormatter.toYyyyMmDd(
                                  item.statusChangedAt,
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
}