/// DB 편집기의 사용자 노출 문자열.
abstract final class DbEditorStrings {
  static const empty = '데이터가 없습니다.';
  static const columnLabel = 'Column';
  static const valueLabel = 'Value';
  static const search = '검색';
  static const resetSearch = '검색 초기화';
  static const add = '추가';
  static const delete = '삭제';
  static const edit = '수정';
  static const save = '저장';
  static const loadFailed = '데이터를 불러오지 못했습니다.';
  static const selectSearchColumn = '검색할 컬럼을 선택해주세요.';
  static const enterSearchValue = '검색할 값을 입력해주세요.';
  static const unsavedBeforeSearch =
      '저장하지 않은 변경사항이 있습니다. 저장하거나 변경사항을 취소한 후 검색해주세요.';
  static const unsavedBeforeClearSearch =
      '저장하지 않은 변경사항이 있습니다. 저장하거나 변경사항을 취소한 후 검색을 초기화해주세요.';
  static const unsavedBeforeSort =
      '저장하지 않은 변경사항이 있습니다. 저장하거나 변경사항을 취소한 후 정렬해주세요.';
  static const missingRequiredValue = '채우지 않은 데이터가 있습니다';
  static const actionFailed = '요청을 처리하지 못했습니다. 잠시 후 다시 시도해주세요.';

  // 튜토리얼
  static const usageColumn = '컬럼을 클릭하면 해당 열을 오름차순/내림차순 정렬 할 수 있어요';
  static const usageView = '셀을 더블클릭하면 해당 셀을 편집 할 수 있어요';
  static const usageAdd = '행을 추가하는 버튼이에요';
  static const usageDelete = '선택한 행을 삭제하는 버튼이에요';
  static const usageEdit = '선택한 셀을 편집하는 버튼이에요';
  static const usageSave = '변경 사항을 저장하는 버튼이에요';

  static String duplicateKey(String key) => '중복된 키값 $key으로는 학습할 수 없습니다';
  static String saveFailed(String message) => '저장 실패: $message';
  static String deleteFailed(String message) => '삭제 실패: $message';
  static String saveError(String message) => '저장 실패 : $message';

  /// 사용자에게 보여줄 오류 문구. 의도한 안내(StateError)만 그대로 보여주고
  /// 그 밖의 예외는 내부 정보를 노출하지 않도록 일반 문구로 바꾼다.
  static String errorMessage(Object error) =>
      error is StateError ? error.message : actionFailed;
}
