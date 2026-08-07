
import 'package:flutter/cupertino.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';
import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';
import 'DBColumn.dart';
import 'DBModel.dart';

class DBController extends ChangeNotifier {
  final RepositoryInterface repository;
  DBModel model;
  bool isEditMode = false;

  DBController(List<Entity> entities, {
    required this.repository,
  }) : model = DBModel(entities);

  /// Getter
  String get(int colIndex, int rowIndex) {
    return model[colIndex][rowIndex];
  }

  /// Edit
  void toggleEditMode() {
    if (isEditMode) {
      isEditMode = false;
    } else {
      isEditMode = true;
    }
    notifyListeners();
  }

  // void edit(int colIndex, int rowIndex, String value) {
  //   if (isEditMode) {
  //     model[colIndex][rowIndex] = value;
  //     Map<String, String> updatedRow = model.getRows()[rowIndex];
  //   } else {
  //     // TODO : throw Exception
  //   }
  // }

  /// Select
  List<int> getSelectedCell() {
    return model.getSelectedCell();
  }

  void setSelectedCell(int colIndex, int rowIndex) {
    model.setSelectedCell(colIndex, rowIndex);
    notifyListeners();
  }

  /// Sort
  void sort(String colName) {
    DBColumn col = model.columns.firstWhere((c) => c.toString() == colName);
    bool isAscending = col.toggle();
    model.sort(colName, isAscending: isAscending);
    notifyListeners();
  }

  /// Filter
  // TODO : or, and 연산자에 대한 구현 방법 필요
  // MEMO : 필터는 아마 컬럼 객체에다 걸 듯?
  // void filter(String name, String value) {
  //   model.filter(name, value);
  //   notifyListeners();
  // }
  //
  // void clearFilter() {
  //
  // }

  /// Column
  List<String> getColumns() {
    // model.columns는 List<DBColumn>
    return model.columns.map((c) => c.toString()).toList();
  }

  int get countColumn => model.columns.length;

  /// DBRow
  void addRow() {
    model.addRow();
    isEditMode = true;  // 행을 추가하면 새로 추가한 행의 첫번째 열은 자동으로 수정 모드
    notifyListeners();
  }

  void deleteRow() {
    model.deleteRow();
    notifyListeners();
  }

  List<String> _extractPkColumns(Map<String, String> row) {
    List<String> pkColumns = [];
    final columns = model.columns;
    for (int i=0; i<columns.length; i++) {
      if (columns[i].isPrimary()) {
        pkColumns.add(row[columns[i].toString()]!);
      }
    }
    return pkColumns;
  }

  int get countRow => model.rowCount;

  /// Save
  Future<List<String>> save() async {
    bool isBlank(String? s) => s == null || s.trim().isEmpty;

    String pkKey(Map<String, String> row) {
      final pkValues = _extractPkColumns(row); // <- 기존 함수 사용

      if (pkValues.isEmpty) {
        throw StateError('채우지 않은 데이터가 있습니다');
      }
      for (final v in pkValues) {
        if (isBlank(v)) {
          throw StateError('채우지 않은 데이터가 있습니다');
        }
      }
      // 복합 PK 지원: 구분자로 join
      return pkValues.map((e) => e.trim()).join('¦');
    }

    bool rowsEqual(Map<String, String> a, Map<String, String> b) {
      // 모델의 컬럼 전체 비교(수정 여부 판단)
      for (final c in model.columns) {
        final k = c.toString();
        if ((a[k] ?? '') != (b[k] ?? '')) return false;
      }
      return true;
    }

    // 현재/원본 행 리스트
    final currentRows = model.getRows();
    final originRows = (() {
      if (model.origin.isEmpty) return <Map<String, String>>[];

      final cols = model.columns.map((c) => c.toString()).toList();
      final rowCount = model.origin.values.isEmpty ? 0 : model.origin.values.first.length;

      return List<Map<String, String>>.generate(rowCount, (i) {
        final row = <String, String>{};
        for (final col in cols) {
          row[col] = model.origin[col]![i];
        }
        return row;
      });
    })();

    // PK 기준으로 맵 구성 + 중복 PK 검사
    final currentByPk = <String, Map<String, String>>{};
    for (final r in currentRows) {
      final key = pkKey(r);
      if (currentByPk.containsKey(key)) {
        throw StateError('중복된 키값 $key으로는 학습할 수 없습니다');
      }
      currentByPk[key] = r;
    }

    final originByPk = <String, Map<String, String>>{};
    for (final r in originRows) {
      final key = pkKey(r);
      if (originByPk.containsKey(key)) {
        throw StateError('중복된 키값 $key으로는 학습할 수 없습니다');
      }
      originByPk[key] = r;
    }

    // added + modified => saveAll
    final toSave = <Map<String, String>>[];
    for (final e in currentByPk.entries) {
      final key = e.key;
      final cur = e.value;
      final orig = originByPk[key];
      if (orig == null || !rowsEqual(cur, orig)) {
        toSave.add(cur);
      }
    }

    // deleted => deleteAll
    final toDelete = <Map<String, String>>[];
    for (final e in originByPk.entries) {
      if (!currentByPk.containsKey(e.key)) {
        toDelete.add(e.value);
      }
    }

    List<String> messages = [];
    if (toSave.isNotEmpty) {
      final saveResult = await repository.saveAll(toSave);
      if (saveResult['success'] == true) {
        final List<String> responseList = List<String>.from(saveResult['response']);
        messages = [...messages, ...responseList];
      } else {
        messages.add("저장 실패: ${saveResult['error']['message']}");
      }
    }
    if (toDelete.isNotEmpty) {
      final deleteResult = await repository.deleteAll(toDelete);
      if (deleteResult['success'] == true) {
        final String response = deleteResult['response'];
        messages.add(response);
      } else {
        messages.add("삭제 실패: ${deleteResult['error']['message']}");
      }
    }
    model.reset();
    return messages;
  }
}