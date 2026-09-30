/// 현재 채팅방에서 고를 수 있는 대회 게시판.
class CompetitionBoard {
  /// 게시 요청에 보내는 설정 키(inner_board, outer_board 등)
  final String key;
  final String channelId;
  final String name;

  /// 참가 이모지·참가자 역할·대회방이 자동으로 만들어지는 게시판인지
  final bool joinable;

  const CompetitionBoard({
    required this.key,
    required this.channelId,
    required this.name,
    required this.joinable,
  });
}
