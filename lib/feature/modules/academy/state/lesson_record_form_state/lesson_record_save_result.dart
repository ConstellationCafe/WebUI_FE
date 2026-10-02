/// 수업 기록 저장 시도 결과. 화면이 실패 원인에 맞는 안내를 고르는 데 쓴다.
enum LessonRecordSaveResult {
  /// 저장 성공.
  saved,

  /// 필수 항목 누락 또는 수업 시간 범위가 올바르지 않아 요청하지 않음.
  invalid,

  /// 입력은 유효했지만 저장 요청이 실패함.
  failed,
}
