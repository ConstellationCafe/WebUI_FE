/// 대회 공지 입력 제약. WebUI_BE `CompetitionNoticeFormatter`의 규칙과 같은 값을 쓴다.
///
/// 최종 검증은 서버가 하며(미리보기 API), 여기서는 입력 중에 바로 알려 줄 수 있는 것만 확인한다.
abstract final class CompetitionInputRules {
  static const titleMaxLength = 100;
  static const keyMaxLength = 30;
  static const valueMaxLength = 2000;
  static const maxPrizes = 10;
  static const maxExtraFields = 10;

  /// 고정 입력란과 같은 이름이라 추가 입력란 이름으로 쓸 수 없는 값
  static const reservedKeys = {'참가 방법', '진행 형식', '접수 기간', '진행 기간', '우승 상품'};

  static bool isSingleLine(String value) =>
      !value.contains('\n') && !value.contains('\r');
}
