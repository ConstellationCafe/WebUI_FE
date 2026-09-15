import 'package:flutter/cupertino.dart';

import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';
import 'package:constellation_cafe/shared/domain/entity/entity_interface.dart';

import '../../model/db_editor/DBModel.dart';
import '../../model/db_editor/DBColumn.dart';

class DBController extends ChangeNotifier {
  final RepositoryInterface repository;

  final DBModel model = DBModel();

  bool isEditMode = false;

  /// Pagination
  int currentPage = 0;
  final int pageSize;

  bool isLoading = false;
  bool hasNext = true;
  bool isInitialized = false;

  /// Search
  String? searchColumn;
  String? searchValue;

  /// Sort
  String? sortColumn;
  String? sortDirection;

  DBController({
    required this.repository,
    this.pageSize = 20,
  });

  // ============================================================
  // Getter
  // ============================================================

  String get(int colIndex, int rowIndex) {
    return model[colIndex][rowIndex];
  }

  int get countColumn => model.columns.length;

  int get countRow => model.rowCount;

  bool get hasUnsavedChanges => _hasUnsavedChanges();

  List<String> getColumns() {
    return model.columns
        .map((column) => column.toString())
        .toList();
  }

  // ============================================================
  // Pagination
  // ============================================================

  /// 최초 페이지 조회
  ///
  /// 검색/정렬 조건이 존재하면 해당 조건을 유지한 채
  /// page 1을 다시 조회한다.
  Future<void> loadInitialPage() async {
    if (isLoading) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final result = await repository.findPage(
        page: 1,
        size: pageSize,
        searchColumn: searchColumn,
        searchValue: searchValue,
        sortColumn: sortColumn,
        sortDirection: sortDirection,
      );

      model.replace(
        List<Entity>.from(result.items),
      );

      currentPage = result.page;
      hasNext = result.hasNext;
      isInitialized = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// 다음 페이지 조회
  ///
  /// 기존 데이터는 유지하고 서버에서 받은 다음 페이지를 append 한다.
  Future<void> loadNextPage() async {
    if (isLoading || !hasNext) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final nextPage = currentPage + 1;

      final result = await repository.findPage(
        page: nextPage,
        size: pageSize,
        searchColumn: searchColumn,
        searchValue: searchValue,
        sortColumn: sortColumn,
        sortDirection: sortDirection,
      );

      model.append(
        List<Entity>.from(result.items),
      );

      currentPage = result.page;
      hasNext = result.hasNext;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// 현재 검색/정렬 조건을 유지하면서 page 1부터 다시 조회
  Future<void> reload() async {
    currentPage = 0;
    hasNext = true;

    await loadInitialPage();
  }

  // ============================================================
  // Edit
  // ============================================================

  void toggleEditMode() {
    isEditMode = !isEditMode;

    notifyListeners();
  }

  // ============================================================
  // Select
  // ============================================================

  List<int> getSelectedCell() {
    return model.getSelectedCell();
  }

  void setSelectedCell(
      int colIndex,
      int rowIndex,
      ) {
    model.setSelectedCell(
      colIndex,
      rowIndex,
    );

    notifyListeners();
  }

  // ============================================================
  // Search
  // ============================================================

  Future<void> search(
      String columnName,
      String value,
      ) async {
    if (_hasUnsavedChanges()) {
      throw StateError(
        '저장하지 않은 변경사항이 있습니다. '
            '저장하거나 변경사항을 취소한 후 검색해주세요.',
      );
    }

    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      await clearSearch();
      return;
    }

    final column = model.columns.firstWhere(
          (column) =>
      column.toString() == columnName,
    );

    /*
     * 화면 컬럼명이 아니라 실제 DB 컬럼명을 서버로 전달
     *
     * ex)
     *
     * cnValue
     *     ↓
     * cn_value
     */
    searchColumn = column.dbName;
    searchValue = trimmedValue;

    currentPage = 0;
    hasNext = true;

    await loadInitialPage();
  }

  /// 검색 조건 제거
  ///
  /// 정렬 조건은 그대로 유지한다.
  Future<void> clearSearch() async {
    if (_hasUnsavedChanges()) {
      throw StateError(
        '저장하지 않은 변경사항이 있습니다. '
            '저장하거나 변경사항을 취소한 후 검색을 초기화해주세요.',
      );
    }

    searchColumn = null;
    searchValue = null;

    currentPage = 0;
    hasNext = true;

    await loadInitialPage();
  }

  // ============================================================
  // Sort
  // ============================================================

  Future<void> sort(String colName) async {
    if (_hasUnsavedChanges()) {
      throw StateError(
        '저장하지 않은 변경사항이 있습니다. '
            '저장하거나 변경사항을 취소한 후 정렬해주세요.',
      );
    }

    final column = model.columns.firstWhere(
          (column) =>
      column.toString() == colName,
    );

    /*
     * 다른 컬럼의 정렬 상태 초기화
     */
    for (final otherColumn in model.columns) {
      if (otherColumn != column) {
        otherColumn.clearSort();
      }
    }

    /*
     * none -> asc
     * asc  -> desc
     * desc -> asc
     */
    final isAscending = column.toggle();

    /*
     * 실제 DB 컬럼명을 서버로 전달
     *
     * ex)
     * cnValue -> cn_value
     */
    sortColumn = column.dbName;

    sortDirection =
    isAscending ? 'ASC' : 'DESC';

    currentPage = 0;
    hasNext = true;

    await loadInitialPage();
  }

  // ============================================================
  // Row
  // ============================================================

  void addRow() {
    model.addRow();

    /*
     * 행을 추가하면 바로 수정 가능하도록 Edit Mode 활성화
     */
    isEditMode = true;

    notifyListeners();
  }

  void deleteRow() {
    model.deleteRow();

    notifyListeners();
  }

  // ============================================================
  // Unsaved Changes
  // ============================================================

  bool _hasUnsavedChanges() {
    final current = model.table;
    final origin = model.origin;

    /*
     * 컬럼 수가 다르면 변경
     */
    if (current.keys.length !=
        origin.keys.length) {
      return true;
    }

    for (final key in origin.keys) {
      final currentValues = current[key];
      final originValues = origin[key];

      if (currentValues == null ||
          originValues == null) {
        return true;
      }

      /*
       * Add / Delete 발생
       */
      if (currentValues.length !=
          originValues.length) {
        return true;
      }

      /*
       * Cell 수정 발생
       */
      for (
      int i = 0;
      i < originValues.length;
      i++
      ) {
        if (currentValues[i] !=
            originValues[i]) {
          return true;
        }
      }
    }

    return false;
  }

  // ============================================================
  // Primary Key
  // ============================================================

  List<String> _extractPkColumns(
      Map<String, String> row,
      ) {
    final List<String> pkColumns = [];

    final columns = model.columns;

    for (
    int i = 0;
    i < columns.length;
    i++
    ) {
      if (columns[i].isPrimary()) {
        pkColumns.add(
          row[
          columns[i].toString()
          ]!,
        );
      }
    }

    return pkColumns;
  }

  // ============================================================
  // Save
  // ============================================================

  Future<List<String>> save() async {
    bool isBlank(String? value) {
      return value == null ||
          value.trim().isEmpty;
    }

    String pkKey(
        Map<String, String> row,
        ) {
      final pkValues =
      _extractPkColumns(row);

      if (pkValues.isEmpty) {
        throw StateError(
          '채우지 않은 데이터가 있습니다',
        );
      }

      for (final value in pkValues) {
        if (isBlank(value)) {
          throw StateError(
            '채우지 않은 데이터가 있습니다',
          );
        }
      }

      /*
       * 복합 PK 지원
       */
      return pkValues
          .map(
            (value) => value.trim(),
      )
          .join('¦');
    }

    bool rowsEqual(
        Map<String, String> a,
        Map<String, String> b,
        ) {
      for (final column in model.columns) {
        final key = column.toString();

        if ((a[key] ?? '') !=
            (b[key] ?? '')) {
          return false;
        }
      }

      return true;
    }

    // ----------------------------------------------------------
    // 현재 데이터
    // ----------------------------------------------------------

    final currentRows =
    model.getRows();

    // ----------------------------------------------------------
    // 원본 데이터
    // ----------------------------------------------------------

    final originRows = (() {
      if (model.origin.isEmpty) {
        return <Map<String, String>>[];
      }

      final columns = model.columns
          .map(
            (column) =>
            column.toString(),
      )
          .toList();

      final rowCount =
      model.origin.values.isEmpty
          ? 0
          : model
          .origin
          .values
          .first
          .length;

      return List<
          Map<String, String>
      >.generate(
        rowCount,
            (index) {
          final row =
          <String, String>{};

          for (final column in columns) {
            row[column] =
            model.origin[column]![index];
          }

          return row;
        },
      );
    })();

    // ----------------------------------------------------------
    // 현재 행 PK Map
    // ----------------------------------------------------------

    final currentByPk =
    <String, Map<String, String>>{};

    for (final row in currentRows) {
      final key = pkKey(row);

      if (currentByPk.containsKey(key)) {
        throw StateError(
          '중복된 키값 $key으로는 학습할 수 없습니다',
        );
      }

      currentByPk[key] = row;
    }

    // ----------------------------------------------------------
    // 원본 행 PK Map
    // ----------------------------------------------------------

    final originByPk =
    <String, Map<String, String>>{};

    for (final row in originRows) {
      final key = pkKey(row);

      if (originByPk.containsKey(key)) {
        throw StateError(
          '중복된 키값 $key으로는 학습할 수 없습니다',
        );
      }

      originByPk[key] = row;
    }

    // ----------------------------------------------------------
    // 추가 + 수정
    // ----------------------------------------------------------

    final toSave =
    <Map<String, String>>[];

    for (final entry
    in currentByPk.entries) {
      final key = entry.key;
      final currentRow = entry.value;

      final originRow =
      originByPk[key];

      if (originRow == null ||
          !rowsEqual(
            currentRow,
            originRow,
          )) {
        toSave.add(
          currentRow,
        );
      }
    }

    // ----------------------------------------------------------
    // 삭제
    // ----------------------------------------------------------

    final toDelete =
    <Map<String, String>>[];

    for (final entry
    in originByPk.entries) {
      if (!currentByPk.containsKey(
        entry.key,
      )) {
        toDelete.add(
          entry.value,
        );
      }
    }

    // ----------------------------------------------------------
    // API
    // ----------------------------------------------------------

    final List<String> messages = [];

    if (toSave.isNotEmpty) {
      final saveResult =
      await repository.saveAll(
        toSave,
      );

      if (saveResult['success'] == true) {
        final response =
        saveResult['response'];

        if (response is List) {
          messages.addAll(
            response
                .map(
                  (e) => e.toString(),
            )
                .toList(),
          );
        }
      } else {
        messages.add(
          "저장 실패: "
              "${saveResult['error']['message']}",
        );
      }
    }

    if (toDelete.isNotEmpty) {
      final deleteResult =
      await repository.deleteAll(
        toDelete,
      );

      if (deleteResult['success'] ==
          true) {
        final response =
        deleteResult['response'];

        messages.add(
          response.toString(),
        );
      } else {
        messages.add(
          "삭제 실패: "
              "${deleteResult['error']['message']}",
        );
      }
    }

    /*
     * 저장 성공 후에는 현재 서버 상태를 다시 조회한다.
     *
     * 검색/정렬 조건은 유지한다.
     */
    if (toSave.isNotEmpty ||
        toDelete.isNotEmpty) {
      isEditMode = false;

      currentPage = 0;
      hasNext = true;

      await loadInitialPage();
    }

    return messages;
  }
}