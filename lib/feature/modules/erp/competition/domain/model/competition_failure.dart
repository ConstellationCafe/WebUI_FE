/// 대회 공지 요청이 실패한 이유. 화면은 이유에 맞는 안내 문구를 보여준다.
enum CompetitionFailureReason {
  /// 입력이 봇 파서 규칙이나 게시 제약을 어김(400). 서버 안내 문구를 그대로 보여준다.
  invalid,

  /// 현재 채팅방에 대회 게시판·봇 설정이 없음(404)
  notConfigured,

  /// 디스코드 게시 실패(502). 서버 안내 문구를 그대로 보여준다.
  discord,

  /// 네트워크 오류 등 결과를 알 수 없음. 같은 요청 ID로 몇 분 안에 다시 보내면 중복 게시되지 않는다.
  unknown,
}

class CompetitionException implements Exception {
  final CompetitionFailureReason reason;

  /// 서버가 보낸 안내 문구. 관리자에게 그대로 보여 줄 수 있게 작성돼 있다.
  final String? message;

  const CompetitionException(this.reason, [this.message]);

  @override
  String toString() => 'CompetitionException($reason)';
}
