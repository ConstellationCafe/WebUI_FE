import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';

import 'DBColumn.dart';

class DBModel {
  Map<String, List<String>> origin = {};
  Map<String, List<String>> table = {};
  // 실제 값과 화면 표시값이 다른 컬럼만 저장
  Map<String, List<String>> displayValues = {};

  List<DBColumn> columns = [];

  int _selectedRow = 0;
  int _selectedCol = 0;

  DBModel();

  ColumnView operator [](int colIndex) {
    final colName = columns[colIndex].toString();

    return ColumnView(
      getter: (rowIndex) => table[colName]![rowIndex],
      setter: (rowIndex, value) {
        table[colName]![rowIndex] = value;
      },
    );
  }

  String getDisplayValue(
      int colIndex,
      int rowIndex,
      ) {
    final colName = columns[colIndex].toString();

    final displayColumn = displayValues[colName];

    if (displayColumn != null &&
        rowIndex >= 0 &&
        rowIndex < displayColumn.length) {
      return displayColumn[rowIndex];
    }

    return table[colName]![rowIndex];
  }

  int get colCount => columns.length;

  int get rowCount {
    if (table.isEmpty) {
      return 0;
    }

    return table.values.first.length;
  }

  List<int> getSelectedCell() {
    return [
      _selectedCol,
      _selectedRow,
    ];
  }

  void setSelectedCell(
      int colIndex,
      int rowIndex,
      ) {
    _selectedCol = colIndex;
    _selectedRow = rowIndex;
  }

  /// 첫 페이지 / 검색 / 정렬 결과
  void replace(
      List<Entity> entities,
      List<Map<String, dynamic>> metadata,
      ) {
    // 데이터 존재 여부와 관계없이
    // metadata를 이용해서 컬럼부터 초기화
    _initializeColumns(metadata);

    final newTable = _createEmptyTable();
    final newDisplayValues =
    <String, List<String>>{};

    for (final entity in entities) {
      final json = entity.toJson();
      final displayJson = entity.toDisplayJson();

      for (final column in columns) {
        final name = column.toString();

        newTable[name]!.add(
          (json[name] ?? '').toString(),
        );
      }

      // 실제 값과 표시값이 다른 컬럼만 저장
      for (final entry in displayJson.entries) {
        newDisplayValues
            .putIfAbsent(
          entry.key,
              () => <String>[],
        )
            .add(
          (entry.value ?? '').toString(),
        );
      }
    }

    table = {
      for (final entry in newTable.entries)
        entry.key:
        List<String>.from(entry.value),
    };
    origin = {
      for (final entry in newTable.entries)
        entry.key:
        List<String>.from(entry.value),
    };
    displayValues = {
      for (final entry in newDisplayValues.entries)
        entry.key:
        List<String>.from(entry.value),
    };

    _selectedCol = 0;
    _selectedRow = 0;
  }

  /// 무한스크롤로 다음 페이지 추가
  void append(List<Entity> entities) {
    if (entities.isEmpty) {
      return;
    }
    // append 전에 columns가 없는 것은 정상적인 상태가 아님
    if (columns.isEmpty) {
      throw StateError(
        'DBModel이 초기화되지 않은 상태에서 append할 수 없습니다.',
      );
    }

    for (final entity in entities) {
      final json = entity.toJson();
      final displayJson = entity.toDisplayJson();

      for (final column in columns) {
        final name = column.toString();
        final value =
        (json[name] ?? '').toString();

        table[name]!.add(value);
        origin[name]!.add(value);
      }

      for (final entry in displayJson.entries) {
        displayValues
            .putIfAbsent(
          entry.key,
              () => <String>[],
        )
            .add(
          (entry.value ?? '').toString(),
        );
      }
    }
  }

  void _initializeColumns(
      List<Map<String, dynamic>> metadata,
      ) {
    if (columns.isNotEmpty) {
      return;
    }

    columns = metadata.map(
      (meta) {
        final name = meta['colName'].toString();
        return DBColumn(
          name: name,
          dbName: (meta['dbName'] ?? name).toString(),
          isPrimary: (meta['isPrimary'] as num?)?.toInt() ?? 0,
          isNullable: (meta['isNullable'] as num?)?.toInt() ?? 1,
        );
      },
    ).toList();
  }

  Map<String, List<String>> _createEmptyTable() {
    return {
      for (final column in columns)
        column.toString(): <String>[],
    };
  }

  void _clearRows() {
    table = _createEmptyTable();

    origin = _createEmptyTable();

    _selectedCol = 0;
    _selectedRow = 0;
  }

  List<Map<String, String>> getRows() {
    if (table.isEmpty) {
      return [];
    }

    return List.generate(
      rowCount,
          (rowIndex) {
        final row = <String, String>{};

        for (final column in columns) {
          final name = column.toString();

          row[name] = table[name]![rowIndex];
        }

        return row;
      },
    );
  }

  void addRow() {
    for (final column in columns) {
      table[column.toString()]!.add('');
    }

    // 표시 전용 컬럼만 행 개수를 맞춰준다.
    for (final values in displayValues.values) {
      values.add('');
    }

    if (rowCount > 0) {
      _selectedRow = rowCount - 1;
      _selectedCol = 0;
    }
  }

  void deleteRow() {
    if (rowCount == 0) {
      return;
    }

    if (_selectedRow < 0 || _selectedRow >= rowCount) {
      return;
    }

    for (final column in columns) {
      table[column.toString()]!.removeAt(
        _selectedRow,
      );
    }

    for (final values in displayValues.values) {
      if (_selectedRow < values.length) {
        values.removeAt(_selectedRow);
      }
    }

    if (_selectedRow >= rowCount) {
      _selectedRow = rowCount - 1;
    }

    if (_selectedRow < 0) {
      _selectedRow = 0;
    }
  }

  void reset() {
    _selectedCol = 0;
    _selectedRow = 0;

    table = {
      for (final entry in origin.entries)
        entry.key: List<String>.from(
          entry.value,
        ),
    };
  }
}

class ColumnView {
  final String Function(int rowIndex) getter;
  final void Function(
      int rowIndex,
      String value,
      ) setter;

  ColumnView({
    required this.getter,
    required this.setter,
  });

  String operator [](int rowIndex) {
    return getter(rowIndex);
  }

  void operator []=(
      int rowIndex,
      String value,
      ) {
    setter(
      rowIndex,
      value,
    );
  }
}