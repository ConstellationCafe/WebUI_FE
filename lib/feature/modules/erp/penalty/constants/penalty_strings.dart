class PenaltyStrings {
  static const title = '벌점 관리';
  static const history = '벌점 이력';
  static const ranking = '30일 누적 순위';
  static const myPenalties = '내 벌점';
  static const award = '벌점 부여';
  static const cancelPenalty = '벌점 취소';
  static const copyNickname = '닉네임 복사';
  static const copyDiscordId = 'Discord ID 복사';
  static const copiedNickname = '닉네임을 복사했습니다.';
  static const copiedDiscordId = 'Discord ID를 복사했습니다.';
  static const cancel = '닫기';
  static const submit = '확인';
  static const search = '검색';
  static const sort = '정렬';
  static const score = '벌점';
  static const cumulativeScore = '누적 벌점';
  static const cumulativeScoreInline = '누적벌점';
  static const retry = '다시 시도';
  static const targetId = '대상 Discord ID';
  static const channelId = '채널 ID';
  static const channelName = '채널 이름 (선택)';
  static const reason = '사유';
  static const occurredAt = '발생 시각 (선택)';
  static const occurredAtHelper = '현지 시각 기준 · 비워 두면 부여하는 시각으로 기록';
  static const active = '유효';
  static const canceled = '취소됨';
  static const currentScore = '현재 30일 누적';
  static const noHistory = '벌점 내역이 없습니다.';
  static const noRanking = '최근 30일 벌점이 있는 재적 회원이 없습니다.';
  static const selectMember = '순위에서 회원을 선택하면 상세 내역을 볼 수 있습니다.';
  static const loadFailed = '벌점 데이터를 불러오지 못했습니다.';
  static const submitFailed = '처리 결과를 확인할 수 없습니다. 이력을 확인한 뒤 다시 시도하세요.';
  static const cancelFailed = '취소 결과를 확인할 수 없습니다. 이력을 확인해 주세요.';
  static const invalidId = 'Discord ID는 숫자 1~20자리여야 합니다.';
  static const invalidReason = '사유를 1~255자로 입력하세요.';
  static const invalidChannelName = '채널 이름은 100자 이하여야 합니다.';
  static const invalidOccurredAt = '미래가 아닌 날짜와 시각을 선택하세요.';
  static const cancellationNotice = '취소 기록은 이력에 남고 누적 점수에서 제외됩니다.';
  static const previousPage = '이전 페이지';
  static const nextPage = '다음 페이지';
  static const previousHistory = '이전 내역';
  static const nextHistory = '다음 내역';
  static const adminOnly = '관리자만 접근할 수 있습니다.';
  static const sortNewest = '최신순';
  static const sortOldest = '오래된순';
  static const awarded = '벌점이 부여되었습니다.';
  static const canceledResult = '벌점이 취소되었습니다.';
  static const fixedScore = '점수: 1점';
  static const emptyValue = '-';

  static String scoreValue(int points) => '$points점';
  static String scoreSemantics(String label, int points) => '$label $points점';
  static String scoreSummary(int points, int cumulativePoints) =>
      '$score $points점 · $cumulativeScoreInline $cumulativePoints점';
  static String identity(String username, String discordId) =>
      '$username · $discordId';
  static String memberStatus(String discordId, String state) =>
      '$discordId · $state';
  static String rankingSummary(String discordId, int count, String lastAt) =>
      '$discordId · $count건 · $lastAt';
  static String channelInfo(String channel, String channelId) =>
      '채널 $channel ($channelId)';
  static String occurredAtInfo(String dateTime) => '부여시간 $dateTime';
  static String issuerInfo(String issuerId) => '부여자 $issuerId';
  static String cancellationReasonInfo(String reason) => '취소 사유: $reason';
  static String canceledAtInfo(String dateTime) => '취소 시각: $dateTime';
  static String pageIndicator(int page, int totalPages) =>
      '$page / $totalPages';
}
