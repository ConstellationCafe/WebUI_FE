/// SSE 연결에서 받은 원시 이벤트 한 건(이름 + JSON 문자열).
class NotificationStreamFrame {
  final String event;
  final String data;

  const NotificationStreamFrame({required this.event, required this.data});
}

/// 서버가 연결을 끝냈거나(401·503 등) 브라우저가 재연결을 포기했을 때 스트림에 실리는 오류.
/// 일시적인 네트워크 끊김은 브라우저가 스스로 재연결하므로 이 오류가 나지 않는다.
class NotificationStreamClosedException implements Exception {
  const NotificationStreamClosedException();

  @override
  String toString() => 'NotificationStreamClosedException';
}

/// 플랫폼별 SSE 구현을 숨기는 경계. 구독을 취소하면 연결을 닫는다.
abstract interface class NotificationEventSource {
  bool get isSupported;

  Stream<NotificationStreamFrame> open(String url);
}
