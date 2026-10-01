/// 섀도우버스 기능의 사용자 노출 문자열.
abstract final class ShadowverseStrings {
  static const menuTitle = '섀도우버스 메뉴';
  static const friendlyMatchMenu = '친선전';

  // 친선전
  static const cafeName = '섀버 별자리 Cafe';
  static const versionLabel = 'version';
  static const modeLabel = 'mode';
  static const platformLabel = 'BoN';
  static const roomLabel = 'Room';
  static const messageLabel = 'Message';
  static const versionTitle = 'Version';
  static const modeTitle = 'Mode';
  static const platformTitle = 'Platform';
  static const roomTitle = 'Room';
  static const messageTitle = 'Message';
  static const howToRecruit =
      '* 친선모집 방법 : 빗자루의 /친선모집 명령어나 인게임 모집글을 복사해서 붙여넣으세요 !';
  static const submit = '전송';
  static const submitFailed = '전송 실패 : 잠시 후 다시 시도해주세요.';
  static const usageInput = '여기에 친선전 방 정보를 입력하고,';
  static const usageSubmit = '전송 버튼을 누르면 빗자루가 있는 모든 채팅방에 전송할 수 있어요';

  static String senderMatch(String sender) => '$sender님의 친선';
}
