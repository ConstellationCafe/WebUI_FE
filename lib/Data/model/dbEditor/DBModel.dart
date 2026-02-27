import 'package:constellation_cafe/data/model/entity/EntityInterface.dart';
import 'DBColumn.dart';

class DBModel {
  Map<String, List<String>> origin = {};
  Map<String, List<String>> table = {};
  List<DBColumn> columns = [];
  int _selectedRow = 0;
  int _selectedCol = 0;

  DBModel(List<Entity> entities) {
    // 실제로는 entities가 비어있지 않다는 것이 보장됨
    if (entities.isEmpty) {
      throw ArgumentError('entities must not be empty');
    }
    // columns 초기화
    final metadata = entities[0].metadata;
    final metaByName = <String, Map<String, dynamic>>{
      for (final m in metadata)
        (m['colName'] as String): m,
    };
    columns = entities[0].toJson().keys.map((k) {
      final m = metaByName[k];
      final isPrimary = m?['isPrimary'];
      final isNullable = m?['isNullable'];
      return DBColumn(
        name: k,
        isPrimary: isPrimary,
        isNullable: isNullable,
      );
    }).toList();
    // 테이블 초기화
    for (var col in columns) {
      String colName = col.toString();
      table[colName] = [];
      origin[colName] = [];
    }
    // 값 복사
    for (var entity in entities) {
      final json = entity.toJson();
      for (var col in columns) {
        String colName = col.toString();
        table[colName]!.add(json[col.toString()]);
        origin[colName]!.add(json[col.toString()]);
      }
    }
  }

  /// Operator
  ColumnView operator [](int colIndex) {
    if (colIndex < 0 || colIndex >= columns.length) {
      throw RangeError.index(colIndex, columns, 'colIndex');
    }
    return ColumnView(this, colIndex);
  }

  void operator []=(int colIndex, List<String> newValues) {
    if (colIndex < 0 || colIndex >= columns.length) {
      throw RangeError.index(colIndex, columns, 'colIndex');
    }
    final expectedCount = rowCount;  // 중복 호출 방지
    if ((expectedCount!=0) && (newValues.length!=expectedCount)) {
      throw ArgumentError.value(
        newValues.length,
        'newValues.length',
        'Column length mismatch: expected $expectedCount (rowCount), got ${newValues.length}',
      );
    }
    String name = columns[colIndex].toString();
    table[name] = [...newValues];
  }

  int get colCount => columns.length;
  int get rowCount => table.isEmpty ? 0 : table.values.first.length;

  /// Select
  List<int> getSelectedCell() {
    return [_selectedCol, _selectedRow];
  }

  void setSelectedCell(int colIndex, int rowIndex) {
    _selectedCol = colIndex;
    _selectedRow = rowIndex;
  }

  /// Sort
  void sort(String name, { bool isAscending=true }) {
    final rows = getRows();
    rows.sort((a, b) {
      final aVal = a[name]?.toString() ?? '';
      final bVal = b[name]?.toString() ?? '';
      final cmp = aVal.compareTo(bVal);
      return isAscending ? cmp : -cmp;
    });
    _update(rows);
  }

  /// Filter
  // void filter(String name, String value) {
  //   List<Map<String, String>> rows = getRows();
  //   List<Map<String, String>> filteredRows = rows.where((row) => row[name] == value).toList();
  //   _update(filteredRows);
  // }

  /// Row
  List<Map<String, String>> getRows() {
    return List.generate(rowCount, (i) {
      final row = <String, String>{};
      for (var col in columns) {
        row[col.toString()] = table[col.toString()]![i];
      }
      return row;
    });
  }

  void addRow() {
    // 모든 컬럼에 빈 값 추가
    for (var col in columns) {
      table[col.toString()]!.add("");
    }

    // 새로 추가된 행 번호
    _selectedRow = rowCount - 1;
    _selectedCol = 0;
  }

  void deleteRow() {
    int rowToDelete = _selectedRow;
    for (var col in columns) {
      if (rowToDelete < table[col.toString()]!.length) {
        table[col.toString()]!.removeAt(rowToDelete);
      }
    }

    if (_selectedRow >= rowCount) {  // 마지막 행을 삭제했다면
      _selectedRow = rowCount - 1; // 그 직전 행을 마지막 행으로
    }
    else if (_selectedRow < 0) {  // 첫번째 행을 삭제했다면
      _selectedRow = 0;  // 그 다음 행으로 첫번째 행으로
    }
  }

  void _update(List<Map<String, String>> rows) {
    final updated = <String, List<String>>{};

    for (final col in columns) {
      String colName = col.toString();
      updated[colName] = List<String>.generate(
        rows.length,
        (i) => rows[i][colName] ?? '',
        growable: true,
      );
    }
    table = updated;
  }

  /// Export
  List<Map<String, String>> toJsons() {
    if (table.isEmpty) return [];

    final List<Map<String, String>> entities = [];
    for (var i = 0; i < rowCount; i++) {
      final row = <String, String>{};
      for (var col in columns) {
        row[col.toString()] = table[col.toString()]![i];
      }
      entities.add(row);
    }
    return entities;
  }

  /// Status
  void reset() {
    _selectedCol = 0;
    _selectedRow = 0;
    table = {
      for (final e in origin.entries) e.key: List<String>.from(e.value)
    };
  }
}


class ColumnView {
  final DBModel _model;
  final int _colIndex;

  ColumnView(this._model, this._colIndex);

  String operator [](int rowIndex) {
    if (rowIndex < 0 || rowIndex >= _model.rowCount) {
      throw RangeError.range(rowIndex, 0, _model.rowCount - 1, 'rowIndex');
    }
    final name = _model.columns[_colIndex];
    return _model.table[name.toString()]![rowIndex];
  }

  void operator []=(int rowIndex, String cell) {
    if (rowIndex < 0 || rowIndex >= _model.rowCount) {
      throw RangeError.range(rowIndex, 0, _model.rowCount - 1, 'rowIndex');
    }
    final name = _model.columns[_colIndex];
    _model.table[name.toString()]![rowIndex] = cell;
  }
}