import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';

import '../../constants/db_editor_strings.dart';
import '../../constants/db_editor_tokens.dart';
import '../../model/db_editor/db_model.dart';
import '../../state/db_editor/db_editor_state.dart';

part 'db_editor_notifier.g.dart';

/// DB 편집기의 조회·검색·정렬·편집·저장 action.
///
/// 편집기 화면([repository])마다 하나씩 만들어지고, 화면이 사라지면 함께 정리된다.
@riverpod
class DbEditorNotifier extends _$DbEditorNotifier {
  @override
  DbEditorState build(RepositoryInterface repository) {
    return DbEditorState(model: DBModel());
  }

  /// 표 데이터나 화면 상태가 바뀌었음을 알린다.
  void _emit([DbEditorState Function(DbEditorState state)? update]) {
    if (!ref.mounted) return;
    final next = update == null ? state : update(state);
    state = next.copyWith(revision: next.revision + 1);
  }

  // ============================================================
  // Pagination
  // ============================================================

  /// 최초 페이지 조회. 검색·정렬 조건이 있으면 유지한 채 page 1을 다시 조회한다.
  Future<void> loadInitialPage() async {
    if (state.isLoading) {
      return;
    }
    _emit((s) => s.copyWith(isLoading: true));
    try {
      final result = await repository.findPage(
        page: 1,
        size: DbEditorTokens.pageSize,
        searchColumn: state.searchColumn,
        searchValue: state.searchValue,
        sortColumn: state.sortColumn,
        sortDirection: state.sortDirection,
      );
      if (!ref.mounted) return;
      state.model.replace(List<Entity>.from(result.items), result.metadata);
      _emit(
        (s) => s.copyWith(
          currentPage: result.page,
          hasNext: result.hasNext,
          isInitialized: true,
        ),
      );
    } finally {
      _emit((s) => s.copyWith(isLoading: false));
    }
  }

  /// 다음 페이지 조회. 기존 데이터는 유지하고 다음 페이지를 이어 붙인다.
  Future<void> loadNextPage() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    _emit((s) => s.copyWith(isLoading: true));
    try {
      final result = await repository.findPage(
        page: state.currentPage + 1,
        size: DbEditorTokens.pageSize,
        searchColumn: state.searchColumn,
        searchValue: state.searchValue,
        sortColumn: state.sortColumn,
        sortDirection: state.sortDirection,
      );
      if (!ref.mounted) return;
      state.model.append(List<Entity>.from(result.items));
      _emit(
        (s) => s.copyWith(currentPage: result.page, hasNext: result.hasNext),
      );
    } finally {
      _emit((s) => s.copyWith(isLoading: false));
    }
  }

  /// 현재 검색·정렬 조건을 유지하면서 page 1부터 다시 조회한다.
  Future<void> reload() async {
    _emit((s) => s.copyWith(currentPage: 0, hasNext: true));
    await loadInitialPage();
  }

  // ============================================================
  // Edit & Select
  // ============================================================

  void toggleEditMode() {
    _emit((s) => s.copyWith(isEditMode: !s.isEditMode));
  }

  void setSelectedCell(int colIndex, int rowIndex) {
    state.model.setSelectedCell(colIndex, rowIndex);
    _emit();
  }

  /// 입력 중인 셀 값을 반영한다. 글자마다 표 전체를 다시 그리지 않도록 알리지 않는다.
  void updateCell(int colIndex, int rowIndex, String value) {
    state.model[colIndex][rowIndex] = value;
  }

  // ============================================================
  // Search
  // ============================================================

  Future<void> search(String columnName, String value) async {
    if (hasUnsavedChanges) {
      throw StateError(DbEditorStrings.unsavedBeforeSearch);
    }

    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      await clearSearch();
      return;
    }

    final column = state.model.columns.firstWhere(
      (column) => column.toString() == columnName,
    );

    // 화면 컬럼명이 아니라 실제 DB 컬럼명을 서버로 전달한다. 예: cnValue → cn_value
    _emit(
      (s) => s.copyWith(
        searchColumn: column.dbName,
        searchValue: trimmedValue,
        currentPage: 0,
        hasNext: true,
      ),
    );

    await loadInitialPage();
  }

  /// 검색 조건을 지운다. 정렬 조건은 그대로 유지한다.
  Future<void> clearSearch() async {
    if (hasUnsavedChanges) {
      throw StateError(DbEditorStrings.unsavedBeforeClearSearch);
    }

    _emit(
      (s) => s.copyWith(
        searchColumn: null,
        searchValue: null,
        currentPage: 0,
        hasNext: true,
      ),
    );

    await loadInitialPage();
  }

  // ============================================================
  // Sort
  // ============================================================

  Future<void> sort(String colName) async {
    if (hasUnsavedChanges) {
      throw StateError(DbEditorStrings.unsavedBeforeSort);
    }

    final columns = state.model.columns;
    final column = columns.firstWhere((column) => column.toString() == colName);

    // 다른 컬럼의 정렬 상태 초기화
    for (final otherColumn in columns) {
      if (otherColumn != column) {
        otherColumn.clearSort();
      }
    }

    // none -> asc, asc -> desc, desc -> asc
    final isAscending = column.toggle();

    _emit(
      (s) => s.copyWith(
        sortColumn: column.dbName,
        sortDirection: isAscending ? 'ASC' : 'DESC',
        currentPage: 0,
        hasNext: true,
      ),
    );

    await loadInitialPage();
  }

  // ============================================================
  // Row
  // ============================================================

  void addRow() {
    state.model.addRow();
    // 행을 추가하면 바로 수정 가능하도록 Edit Mode를 켠다.
    _emit((s) => s.copyWith(isEditMode: true));
  }

  void deleteRow() {
    state.model.deleteRow();
    _emit();
  }

  // ============================================================
  // Unsaved Changes
  // ============================================================

  bool get hasUnsavedChanges {
    final current = state.model.table;
    final origin = state.model.origin;

    // 컬럼 수가 다르면 변경
    if (current.keys.length != origin.keys.length) {
      return true;
    }

    for (final key in origin.keys) {
      final currentValues = current[key];
      final originValues = origin[key];

      if (currentValues == null || originValues == null) {
        return true;
      }

      // Add / Delete 발생
      if (currentValues.length != originValues.length) {
        return true;
      }

      // Cell 수정 발생
      for (int i = 0; i < originValues.length; i++) {
        if (currentValues[i] != originValues[i]) {
          return true;
        }
      }
    }

    return false;
  }

  // ============================================================
  // Save
  // ============================================================

  List<String> _extractPkColumns(Map<String, String> row) {
    final List<String> pkColumns = [];
    final columns = state.model.columns;

    for (int i = 0; i < columns.length; i++) {
      if (columns[i].isPrimary()) {
        pkColumns.add(row[columns[i].toString()]!);
      }
    }

    return pkColumns;
  }

  Future<List<String>> save() async {
    final model = state.model;

    bool isBlank(String? value) {
      return value == null || value.trim().isEmpty;
    }

    String pkKey(Map<String, String> row) {
      final pkValues = _extractPkColumns(row);

      if (pkValues.isEmpty) {
        throw StateError(DbEditorStrings.missingRequiredValue);
      }

      for (final value in pkValues) {
        if (isBlank(value)) {
          throw StateError(DbEditorStrings.missingRequiredValue);
        }
      }

      // 복합 PK 지원
      return pkValues.map((value) => value.trim()).join('¦');
    }

    bool rowsEqual(Map<String, String> a, Map<String, String> b) {
      for (final column in model.columns) {
        final key = column.toString();

        if ((a[key] ?? '') != (b[key] ?? '')) {
          return false;
        }
      }

      return true;
    }

    final currentRows = model.getRows();

    final originRows = (() {
      if (model.origin.isEmpty) {
        return <Map<String, String>>[];
      }

      final columns = model.columns.map((column) => column.toString()).toList();

      final rowCount = model.origin.values.isEmpty
          ? 0
          : model.origin.values.first.length;

      return List<Map<String, String>>.generate(rowCount, (index) {
        final row = <String, String>{};

        for (final column in columns) {
          row[column] = model.origin[column]![index];
        }

        return row;
      });
    })();

    final currentByPk = <String, Map<String, String>>{};

    for (final row in currentRows) {
      final key = pkKey(row);

      if (currentByPk.containsKey(key)) {
        throw StateError(DbEditorStrings.duplicateKey(key));
      }

      currentByPk[key] = row;
    }

    final originByPk = <String, Map<String, String>>{};

    for (final row in originRows) {
      final key = pkKey(row);

      if (originByPk.containsKey(key)) {
        throw StateError(DbEditorStrings.duplicateKey(key));
      }

      originByPk[key] = row;
    }

    // 추가 + 수정
    final toSave = <Map<String, String>>[];

    for (final entry in currentByPk.entries) {
      final originRow = originByPk[entry.key];

      if (originRow == null || !rowsEqual(entry.value, originRow)) {
        toSave.add(entry.value);
      }
    }

    // 삭제
    final toDelete = <Map<String, String>>[];

    for (final entry in originByPk.entries) {
      if (!currentByPk.containsKey(entry.key)) {
        toDelete.add(entry.value);
      }
    }

    final List<String> messages = [];

    if (toSave.isNotEmpty) {
      final saveResult = await repository.saveAll(toSave);

      if (saveResult['success'] == true) {
        final response = saveResult['response'];

        if (response is List) {
          messages.addAll(response.map((e) => e.toString()).toList());
        }
      } else {
        messages.add(
          DbEditorStrings.saveFailed('${saveResult['error']['message']}'),
        );
      }
    }

    if (toDelete.isNotEmpty) {
      final deleteResult = await repository.deleteAll(toDelete);

      if (deleteResult['success'] == true) {
        messages.add(deleteResult['response'].toString());
      } else {
        messages.add(
          DbEditorStrings.deleteFailed('${deleteResult['error']['message']}'),
        );
      }
    }

    // 저장 후에는 검색·정렬 조건을 유지한 채 현재 서버 상태를 다시 조회한다.
    if (toSave.isNotEmpty || toDelete.isNotEmpty) {
      _emit(
        (s) => s.copyWith(isEditMode: false, currentPage: 0, hasNext: true),
      );

      await loadInitialPage();
    }

    return messages;
  }
}
