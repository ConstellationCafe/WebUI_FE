/// 대회 개최 화면 전용 디자인 상수. 공통 값은 core/constants를 사용한다.
abstract final class CompetitionTokens {
  static const menuIconSize = 20.0;
  static const fieldGap = 16.0;
  static const rowGap = 8.0;
  static const sectionGap = 24.0;
  static const formMaxWidth = 560.0;
  static const compactBreakpoint = 960.0;
  static const previewPadding = 16.0;
  static const previewRadius = 8.0;
  static const previewMinHeight = 160.0;
  static const progressSize = 18.0;
  static const progressStroke = 2.0;
  static const dialogMaxWidth = 440.0;
  static const confirmLabelWidth = 72.0;

  /// 입력이 멈춘 뒤 미리보기를 요청하기까지 기다리는 시간
  static const previewDebounce = Duration(milliseconds: 600);

  /// 날짜 선택기가 허용하는 범위(오늘 기준)
  static const selectableDays = 366;
}
