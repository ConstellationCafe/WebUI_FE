/// 벌점 입력값 제약. Backend의 요청 검증 규칙과 같은 값을 쓴다.
class PenaltyInputRules {
  static const discordIdMaxLength = 20;
  static const channelNameMaxLength = 100;
  static const reasonMaxLength = 255;

  /// Discord ID와 채널 ID는 숫자 1~20자리다.
  static final discordIdPattern = RegExp(r'^[0-9]{1,20}$');
}
