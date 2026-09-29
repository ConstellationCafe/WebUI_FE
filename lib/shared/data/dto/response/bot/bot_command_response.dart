/// 빗자루 봇 router 응답 envelope.
///
/// 성공: `{'payload': {'result': ...}}`. 실패: `{'status_code': false, 'message': ...}`.
/// `result`의 모양은 호출한 봇 함수마다 다르므로 각 기능의 DTO가 해석한다.
class BotCommandResponse {
  final Object? result;
  final String? errorMessage;

  const BotCommandResponse({this.result, this.errorMessage});

  factory BotCommandResponse.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'];
    return BotCommandResponse(
      result: payload is Map ? payload['result'] : null,
      errorMessage: json['status_code'] == false
          ? json['message']?.toString()
          : null,
    );
  }

  /// 봇이 사람이 읽을 결과 문구를 돌려주는 명령의 응답.
  ///
  /// 기존 동작과 같이 결과가 없으면 예외가 난다(호출부가 실패 안내를 보여준다).
  String get resultMessage => result as String;
}
