import 'package:flutter/material.dart';

import '../../constants/db_editor_colors.dart';
import '../../controller/db_editor/DBController.dart';

import 'DBDataCell.dart';

class DBDataView extends StatefulWidget {
  final DBController controller;
  final Set<String> hiddenColumns;
  final Set<String> readOnlyColumns;

  const DBDataView({
    super.key,
    required this.controller,
    this.hiddenColumns = const {},
    this.readOnlyColumns = const {},
  });

  @override
  State<DBDataView> createState() =>
      _DBDataState();
}

class _DBDataState
    extends State<DBDataView> {

  double rowHeight = 40;

  /*
   * Pagination을 위한 ScrollController
   */
  final ScrollController _scrollController =
  ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(
      _onScroll,
    );
  }

  /*
   * 스크롤 위치 감지
   */
  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position =
        _scrollController.position;

    /*
     * 맨 아래에서 200px 정도 남았을 때
     * 다음 페이지를 미리 가져온다.
     */
    if (position.pixels >=
        position.maxScrollExtent - 200) {
      widget.controller.loadNextPage();
    }
  }

  /*
   * Controller 자체가 변경되는 경우 대응
   */
  @override
  void didUpdateWidget(
      covariant DBDataView oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);

    /*
     * 별도의 listener 재등록은 필요 없음.
     * _onScroll에서 항상 widget.controller를
     * 사용하기 때문.
     */
  }

  @override
  void dispose() {
    _scrollController.removeListener(
      _onScroll,
    );

    _scrollController.dispose();

    super.dispose();
  }

  TableRow createRow(
      int rowIndex,
      DBController controller,
      ) {
    final List<int> selectedCell =
    controller.getSelectedCell();

    final visibleColumnIndexes =
    List.generate(
      controller.model.columns.length,
          (index) => index,
    ).where(
          (index) => !widget.hiddenColumns.contains(
        controller.model.columns[index].toString(),
      ),
    ).toList();

    return TableRow(
      children: visibleColumnIndexes.map(
            (colIndex) {
          final isRowSelected =
              rowIndex == selectedCell[1];
          final isCellSelected =
              isRowSelected
              && colIndex == selectedCell[0];
          final columnName =
              controller.model.columns[colIndex].toString();
          final isEditable =
              !widget.readOnlyColumns.contains(columnName);

          return DBDataCell(
            key: ValueKey(
              '${rowIndex}_$colIndex',
            ),
            controller: controller,
            rowIndex: rowIndex,

            // DBModel의 원래 index
            colIndex: colIndex,

            rowHeight: rowHeight,
            isSelected: isCellSelected,
            isEditMode: controller.isEditMode,
            isEditable: !widget.readOnlyColumns.contains(
              columnName,
            ),
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    final controller =
        widget.controller;

    return AnimatedBuilder(
      animation: controller,
      builder: (
          context,
          _,
          ) {
        /*
         * 조회된 데이터가 없는 경우
         */
        if (controller.countRow == 0) {
          if (controller.isLoading) {
            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }

          return const Center(
            child: Text(
              '데이터가 없습니다.',
            ),
          );
        }

        final rows =
        List.generate(
          controller.countRow,
              (rowIndex) =>
              createRow(
                rowIndex,
                controller,
              ),
        );

        return SingleChildScrollView(
          controller:
          _scrollController,
          scrollDirection:
          Axis.vertical,
          child: Table(
            border: const TableBorder(
              top: BorderSide(
                color: DBEditorColors.border,
                width: 1,
              ),
              bottom: BorderSide(
                color: DBEditorColors.border,
                width: 1,
              ),
              left: BorderSide(
                color: DBEditorColors.border,
                width: 1,
              ),
              right: BorderSide(
                color: DBEditorColors.border,
                width: 1,
              ),
              horizontalInside: BorderSide(
                color: DBEditorColors.border,
                width: 1,
              ),
              verticalInside: BorderSide(
                color: DBEditorColors.border,
                width: 1,
              ),
            ),
            children: rows,
          )
        );
      },
    );
  }
}