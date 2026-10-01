abstract final class GuildSelectStrings {
  static const title = '사용할 채팅방을 선택해주세요';
  static const description = '관리할 Discord 채팅방을 선택하면 ERP 서비스를 이용할 수 있습니다.';
  static const footer = '안전한 ERP 서비스를 위해 인증된 채팅방만 표시됩니다.';
  static const emptyTitle = '사용할 수 있는 채팅방이 없습니다.';
  static const emptyDescription = 'ERP 서비스를 이용할 수 있는 채팅방이 없습니다.';
  static const loadFailed = '길드 목록을 불러오지 못했습니다.';
  static String memberCount(int count) => '$count명';

  static const connecting = '채팅방에 연결하고 있습니다…';
  static const selectionFailed = '이 채팅방을 선택할 수 없습니다. 멤버 여부를 확인해주세요.';
  static const checkFailed = '로그인 상태를 확인하지 못했습니다. 다시 선택해주세요.';
}
