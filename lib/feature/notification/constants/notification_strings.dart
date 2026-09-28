/// 알림 기능의 사용자 노출 문자열.
class NotificationStrings {
  // 종 아이콘·알림 패널
  static const bellTooltip = '알림';
  static const bellUnreadLabel = '읽지 않은 알림 있음';
  static const panelTitle = '알림';
  static const empty = '받은 알림이 없습니다.';
  static const loadFailed = '알림을 불러오지 못했습니다.';
  static const retry = '다시 시도';
  static const loadMore = '이전 알림 더 보기';
  static const newBadge = '새 알림';
  static const close = '닫기';
  static const noBody = '등록된 내용이 없습니다.';
  static const justNow = '방금 전';

  static String minutesAgo(int minutes) => '$minutes분 전';

  static String hoursAgo(int hours) => '$hours시간 전';

  static String unreadCount(int count) => '읽지 않은 알림 $count개';

  // 분류
  static const announcement = '공지';
  static const event = '이벤트';
  static const point = '포인트';
  static const system = '시스템';

  // 관리자 발행 화면
  static const adminTitle = '알림 발행';
  static const adminMenu = '알림 발행';
  static const targetLabel = '받는 사람';
  static const targetGuild = '채팅방 전체';
  static const targetUser = '특정 회원';
  static const targetDiscordId = '회원 Discord ID';
  static const categoryLabel = '분류';
  static const titleLabel = '제목';
  static const bodyLabel = '내용';
  static const linkLabel = '이동 경로 (선택)';
  static const linkHelper = '예: /point_log  알림을 누르면 이 화면으로 이동합니다.';
  static const publish = '발행';
  static const published = '알림을 발행했습니다.';
  static const alreadyPublished = '이미 발행된 알림입니다. 이력을 확인해 주세요.';
  static const history = '발행 이력';
  static const noHistory = '발행한 알림이 없습니다.';
  static const historyFailed = '발행 이력을 불러오지 못했습니다.';
  static const previousPage = '이전 페이지';
  static const nextPage = '다음 페이지';
  static const sourceAdmin = '관리자';
  static const sourceInternal = '자동';
  static const sourceExternal = '외부 연동';

  // 입력 검증과 실패 안내
  static const titleRequired = '제목을 입력하세요.';
  static const titleTooLong = '제목은 100자 이하로 입력하세요.';
  static const bodyRequired = '내용을 입력하세요.';
  static const bodyTooLong = '내용은 1,000자 이하로 입력하세요.';
  static const discordIdInvalid = '숫자로 된 Discord ID를 입력하세요.';
  static const linkInvalid = "'/'로 시작하는 앱 내부 경로만 입력할 수 있습니다.";
  static const notMember = '현재 채팅방의 재적 회원이 아닙니다. Discord ID를 확인하세요.';
  static const conflict = '같은 요청으로 다른 내용이 발행되어 있습니다. 내용을 확인하고 다시 발행하세요.';
  static const invalid = '입력한 내용을 확인해 주세요.';
  static const publishUnknown = '발행 결과를 확인할 수 없습니다. 다시 발행해도 중복되지 않습니다.';
}
