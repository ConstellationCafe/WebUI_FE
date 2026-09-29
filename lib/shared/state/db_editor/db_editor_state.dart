import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/db_editor/db_model.dart';

part 'db_editor_state.freezed.dart';

/// DB 편집기 화면 상태.
///
/// 표 데이터([model])는 셀 입력마다 전체 화면을 다시 그리지 않도록 가변 모델로 두고,
/// 목록·선택·편집 모드가 바뀔 때마다 [revision]을 올려 화면에 변경을 알린다.
@freezed
abstract class DbEditorState with _$DbEditorState {
  const DbEditorState._();

  const factory DbEditorState({
    required DBModel model,
    @Default(0) int revision,
    @Default(false) bool isEditMode,
    @Default(0) int currentPage,
    @Default(false) bool isLoading,
    @Default(true) bool hasNext,
    @Default(false) bool isInitialized,
    String? searchColumn,
    String? searchValue,
    String? sortColumn,
    String? sortDirection,
  }) = _DbEditorState;

  int get countColumn => model.columns.length;

  int get countRow => model.rowCount;

  List<int> get selectedCell => model.getSelectedCell();

  List<String> get columnNames =>
      model.columns.map((column) => column.toString()).toList();
}
