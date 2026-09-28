/// 알림 발행이 거절된 이유. 화면은 이유에 맞는 안내 문구를 보여준다.
enum NotificationPublishFailure {
  /// 개인 알림 대상이 현재 채팅방의 재적 회원이 아님(404)
  notMember,

  /// 같은 요청 ID로 다른 내용이 이미 발행됨(409)
  conflict,

  /// 입력 검증 실패(400)
  invalid,

  /// 네트워크 오류 등 결과를 알 수 없음. 같은 요청 ID로 다시 보내면 중복 발행되지 않는다.
  unknown,
}

class NotificationPublishException implements Exception {
  final NotificationPublishFailure reason;

  const NotificationPublishException(this.reason);

  @override
  String toString() => 'NotificationPublishException($reason)';
}
