/// 대회 공지 게시 결과. 대회 등록과 채팅방 알림은 봇이 이 글을 감지한 뒤 처리한다.
class CompetitionPostResult {
  final String boardKey;
  final String messageId;

  /// 디스코드 공지글 바로가기. 채팅방 정보가 없으면 null
  final String? messageUrl;
  final String content;

  const CompetitionPostResult({
    required this.boardKey,
    required this.messageId,
    required this.messageUrl,
    required this.content,
  });
}
