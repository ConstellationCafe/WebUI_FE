/// 알림 발행 입력 제약. Backend의 요청 검증 규칙과 같은 값을 쓴다.
abstract final class NotificationInputRules {
  static const titleMaxLength = 100;
  static const bodyMaxLength = 1000;
  static const linkMaxLength = 255;
}
