/// 프로필 화면의 사용자 노출 문자열.
abstract final class ProfileStrings {
  static const uid = 'UID';
  static const uid1Label = 'UID1';
  static const uid2Label = 'UID2';
  static const guildLabel = 'Guild';
  static const role = '역할';
  static const guild = '길드';
  static const s1Career = 's1 경력';
  static const s2Career = 's2 경력';
  static const point = '별자리 포인트';
  static const joinAt = '발급 일자';
  static const uidWarning = '* UID의 허위 기재 및 도용시 처벌받을 수 있습니다';
  static const save = '저장';
  static const loadFailed = '회원증을 불러오지 못했습니다.';
  static const retry = '다시 시도';
  static const saveFailed = '저장 중 오류 발생: 잠시 후 다시 시도해주세요.';
  static const unregistered = '미등록';
  static const usageInput = '여기에서 변경할 값을 입력하고 저장 버튼을 누르면 수정 할 수 있어요';
  static const usagePointLog = '또한 해당 버튼을 누르면 포인트 입출 내역를 확인 할 수 있어요';

  static String cardTitle(String username) => '$username님의 회원증';
  static String uidLine(String version, String? uid) =>
      '$version : ${(uid?.isNotEmpty ?? false) ? uid : unregistered}';
}
