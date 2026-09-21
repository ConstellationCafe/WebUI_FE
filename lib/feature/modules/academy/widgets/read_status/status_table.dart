import 'status_badge.dart';
import 'status_empty_view.dart';
import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/utils/date_formatter.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/academy_member.dart';
import '../../domain/model/status_view/status_view.dart';
import '../../domain/type/roster_status.dart';


class StatusTable<
  TMember extends AcademyMember,
  TStatus extends RosterStatus
> extends StatefulWidget {
  final List<StatusView<TMember, TStatus>> items;

  final int totalCount;
  final int currentPage;
  final int pageSize;

  final String title;
  final String memberColumnLabel;
  final String emptyMessage;

  const StatusTable({
    super.key,
    required this.items,
    required this.totalCount,
    required this.currentPage,
    required this.pageSize,
    required this.title,
    required this.memberColumnLabel,
    required this.emptyMessage,
  });

  @override
  State<StatusTable<TMember, TStatus>> createState() =>
      _StatusTableState<TMember, TStatus>();
}

class _StatusTableState<
  TMember extends AcademyMember,
  TStatus extends RosterStatus
> extends State<StatusTable<TMember, TStatus>> {
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = widget.items;
    final totalCount = widget.totalCount;
    final currentPage = widget.currentPage;
    final pageSize = widget.pageSize;
    final title = widget.title;
    final memberColumnLabel = widget.memberColumnLabel;
    final emptyMessage = widget.emptyMessage;

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
                  title,
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: ConstPadding.largePadding,
            ),
            if (items.isEmpty)
              StatusEmptyView(
                message: emptyMessage,
              )
            else
              Scrollbar(
                controller: _horizontalScrollController,
                thumbVisibility: true,
                scrollbarOrientation: ScrollbarOrientation.bottom,
                child: SingleChildScrollView(
                  controller: _horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth:
                      AcademyConstants.statusTableMinWidth,
                    ),
                    child: DataTable(
                      headingRowHeight:
                      AcademyConstants.statusTableHeaderHeight,
                      dataRowMinHeight:
                      AcademyConstants.statusTableRowHeight,
                      dataRowMaxHeight:
                      AcademyConstants.statusTableRowHeight,
                      columnSpacing:
                      AcademyConstants.statusTableColumnSpacing,
                      columns: [
                        const DataColumn(
                          label: Text(
                            '번호',
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            memberColumnLabel,
                          ),
                        ),
                        const DataColumn(
                          label: Text(
                            '아카데미',
                          ),
                        ),
                        const DataColumn(
                          label: Text(
                            '분반',
                          ),
                        ),
                        const DataColumn(
                          label: Text(
                            '상태',
                          ),
                        ),
                        const DataColumn(
                          label: Text(
                            '변경일',
                          ),
                        ),
                        const DataColumn(
                          label: Text(
                            '변경 사유',
                          ),
                        ),
                      ],
                      rows: List.generate(
                        items.length,
                            (index) {
                          final item = items[index];

                          final number =
                              totalCount -
                                  ((currentPage - 1) * pageSize) -
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
                                  item.academyMember.name,
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
                                StatusBadge<TStatus>(
                                  status: item.status,
                                ),
                              ),
                              DataCell(
                                Text(
                                  item.statusChangedAt == null
                                      ? '-'
                                      : DateFormatter.toYyyyMmDd(
                                    item.statusChangedAt!,
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
              ),
          ],
        ),
      ),
    );
  }
}
