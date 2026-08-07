import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/shared/model/db_editor/DBController.dart';

class DBColumns extends ConsumerStatefulWidget {
  final DBController controller;

  const DBColumns({
    super.key,
    required this.controller,
  });

  @override
  ConsumerState<DBColumns> createState() => _DBColumnsState();
}

class _DBColumnsState extends ConsumerState<DBColumns> {
  double rowHeight = 40; // 한 행 높이

  Widget createColum(colIndex, columValues) {
    final String value =
      (colIndex < columValues.length) ? columValues[colIndex].toString() : "";

    return SizedBox(
      height: 40,
      child: GestureDetector(
        onTap: () {
          String colName = widget.controller.getColumns()[colIndex];
          widget.controller.sort(colName);
        },
        child: SizedBox(
          height: rowHeight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final columValues = widget.controller.getColumns();
    final columnsRow = TableRow(
      children: List.generate(
          columValues.length,
          (colIndex) => createColum(colIndex, columValues)
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            border: TableBorder.all(width: 1, color: Colors.grey),
            children: [columnsRow],
          ),
        );
      },
    );
  }
}