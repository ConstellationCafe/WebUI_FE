import 'competition_notice_request.dart';

/// `POST /api/admin/competitions` 본문.
///
/// [requestId]는 게시 시도마다 한 번 만들고, 결과를 모르는 실패 뒤 다시 보낼 때는 같은 값을 쓴다.
/// [boardKey]는 게시판 목록 API가 돌려준 키이며, 서버가 현재 채팅방 설정에서 채널로 바꾼다.
class CompetitionCreateRequest {
  final String requestId;
  final String boardKey;
  final CompetitionNoticeRequest notice;

  const CompetitionCreateRequest({
    required this.requestId,
    required this.boardKey,
    required this.notice,
  });

  Map<String, dynamic> toJson() => {
    'requestId': requestId,
    'boardKey': boardKey,
    'notice': notice.toJson(),
  };
}
