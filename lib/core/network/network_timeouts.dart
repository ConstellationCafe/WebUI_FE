/// 외부 호출 timeout. 값의 근거와 초과 시 동작은 docs/architecture.md의 네트워크 절에 기록한다.
abstract final class NetworkTimeouts {
  /// 서버와 연결을 맺을 때까지 기다리는 최대 시간.
  static const connect = Duration(seconds: 10);

  /// 응답을 받을 때까지 기다리는 최대 시간. 요청별로 더 짧게 줄 수 있다.
  static const receive = Duration(seconds: 30);

  /// Dio를 거치지 않는 인증 요청(check·refresh·logout) 전체 제한.
  static const authRequest = Duration(seconds: 30);

  /// 빗자루 봇 router 호출 전체 제한.
  static const botRouter = Duration(seconds: 10);
}
