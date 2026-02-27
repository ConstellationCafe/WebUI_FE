
import 'package:flutter/material.dart';
import 'package:constellation_cafe/data/model/dbEditor/DBController.dart';
import 'DBDataCell.dart';

class DBDataView extends StatefulWidget {
  final DBController controller;

  const DBDataView({super.key, required this.controller});

  @override
  State<DBDataView> createState() => _DBDataState();
}

class _DBDataState extends State<DBDataView> {
  double rowHeight = 40;

  TableRow createRow(int rowIndex, DBController controller) {
    List<int> selectedCell = controller.getSelectedCell();

    return TableRow(
      children: List.generate(
        controller.getColumns().length,
            (colIndex) {
          final isRowSelected = (rowIndex == selectedCell[1]);
          final isCellSelected = (isRowSelected && colIndex == selectedCell[0]);

          return DBDataCell(
            key: ValueKey('${rowIndex}_$colIndex'),
            controller: controller,
            rowIndex: rowIndex,
            colIndex: colIndex,
            rowHeight: rowHeight,
            isSelected: isCellSelected,
            isEditMode: controller.isEditMode,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final rows = List.generate(
          controller.countRow,
              (rowIndex) => createRow(rowIndex, controller),
        );

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            border: TableBorder.all(width: 1, color: Colors.grey),
            children: rows,
          ),
        );
      },
    );
  }
}
