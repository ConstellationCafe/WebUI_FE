/// 사용자가 선택할 수 있는 채팅방(Discord 길드).
class Guild {
  final String id;
  final String name;
  final String iconUrl;
  final int memberCount;

  const Guild({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.memberCount,
  });
}
