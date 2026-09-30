/// 대회 기능의 사용자 노출 문자열.
abstract final class CompetitionStrings {
  // 메뉴·화면
  static const menuTitle = '대회 메뉴';
  static const menu = '대회 개최';
  static const title = '대회 개최';
  static const formSection = '대회 정보';
  static const previewSection = '디스코드 미리보기';

  // 게시판
  static const boardLabel = '게시판';
  static const boardsLoading = '게시판 목록을 불러오는 중입니다.';
  static const boardsFailed = '게시판 목록을 불러오지 못했습니다.';
  static const noBoards = '현재 채팅방에 대회 게시판 설정이 없습니다.';
  static const joinableHint = '참가 이모지, 참가자 역할, 대회방이 자동으로 만들어집니다.';
  static const notJoinableHint = '대회 일정 안내와 알림만 등록되고, 참가 이모지는 붙지 않습니다.';
  static const retry = '다시 시도';

  // 입력란
  static const titleLabel = '제목';
  static const participantWayLabel = '참가 방법';
  static const participantWayHelper = '예: https://tonamel.com/competition/XXXX';
  static const formatLabel = '진행 형식';
  static const formatHelper = '예: 싱글 엘리미네이션 Bo1';
  static const registrationStartLabel = '접수 시작';
  static const registrationEndLabel = '접수 마감';
  static const eventStartLabel = '진행 시작';
  static const eventEndNote = '진행 기간은 "시작 ~ 종료시까지"로 게시됩니다.';
  static const selectDateTime = '날짜와 시간을 선택하세요';
  static const prizeSection = '우승 상품';
  static const prizeRankLabel = '순위';
  static const prizeContentLabel = '상품';
  static const addPrize = '상품 추가';
  static const extraSection = '추가 입력란';
  static const extraKeyLabel = '항목명';
  static const extraValueLabel = '내용';
  static const addExtra = '입력란 추가';
  static const remove = '삭제';

  // 미리보기
  static const previewEmpty = '필수 항목을 입력하면 실제로 게시될 글이 여기에 표시됩니다.';
  static const previewLoading = '미리보기를 만드는 중입니다.';
  static const previewFailed = '미리보기를 만들지 못했습니다.';
  static const previewValid = '봇이 이 글을 대회 공지로 인식합니다.';

  // 게시
  static const submit = '개최하기';
  static const confirmTitle = '대회를 개최할까요?';
  static const confirmBoard = '게시판';
  static const confirmName = '대회명';
  static const confirmDeadline = '접수 마감';
  static const confirmStart = '진행 시작';
  static const confirmJoinable =
      '게시하면 참가 이모지, 참가자 역할, 대회방이 자동으로 만들어지고 '
      '채팅방 알림이 예약됩니다.';
  static const confirmNotJoinable = '게시하면 대회 일정 안내와 채팅방 알림이 예약됩니다.';
  static const confirmNoEdit = '게시 후 내용을 고치면 일정은 다시 등록되지 않습니다.';
  static const cancel = '취소';
  static const posted = '대회 공지를 게시했습니다.';
  static const openDiscord = '디스코드에서 보기';

  // 입력 검증과 실패 안내
  static const fieldRequired = '필수 항목입니다.';
  static const singleLine = '한 줄로 입력하세요.';
  static const titleQuote = '제목에는 큰따옴표(")를 넣을 수 없습니다.';
  static const reservedKey = '예약된 항목명이라 쓸 수 없습니다.';
  static const keyColon = "항목명에는 ':'를 넣을 수 없습니다.";
  static const duplicateKey = '항목명이 중복됩니다.';
  static const dateRequired = '접수 시작, 접수 마감, 진행 시작을 모두 선택하세요.';
  static const registrationOrder = '접수 마감은 접수 시작보다 늦어야 합니다.';
  static const eventOrder = '진행 시작은 접수 마감과 같거나 늦어야 합니다.';
  static const deadlinePassed = '접수 마감이 이미 지났습니다.';
  static const boardRequired = '게시판을 선택하세요.';
  static const invalid = '입력한 내용을 확인해 주세요.';
  static const discordFailed = '디스코드에 공지를 게시하지 못했습니다. 잠시 후 다시 시도해 주세요.';
  static const postUnknown =
      '게시 결과를 확인할 수 없습니다. 게시판을 확인한 뒤 다시 누르면 '
      '몇 분 안에는 중복 게시되지 않습니다.';

  // 우승 칭호 부여
  static const winnerMenu = '우승 칭호 부여';
  static const winnerTitle = '우승 칭호 부여';
  static const winnerFormSection = '칭호 정보';
  static const winnerCompetitionLabel = '대회명';
  static const winnerDiscordIdLabel = '우승자 Discord ID';
  static const winnerDiscordIdHelper = '현재 채팅방의 재적 회원만 받을 수 있습니다.';
  static const winnerVersionLabel = '게임 버전';
  static const winnerAcquisitionLabel = '대회 개최 날짜';
  static const selectDate = '날짜를 선택하세요';
  static const grant = '칭호 부여';
  static const granted = '우승 칭호를 부여했습니다.';
  static const winnerDiscordIdInvalid = '숫자로 된 Discord ID를 입력하세요.';
  static const acquisitionRequired = '대회 개최 날짜를 선택하세요.';
  static const winnerNotMember = '현재 채팅방의 재적 회원이 아닙니다. Discord ID를 확인하세요.';
  static const winnerConflict = '이미 같은 대회 우승 칭호가 부여된 회원입니다.';
  static const grantUnknown = '부여 결과를 확인할 수 없습니다. 이력을 확인한 뒤 다시 시도하세요.';
  static const winnerHistory = '부여 이력';
  static const noWinnerHistory = '부여한 우승 칭호가 없습니다.';
  static const winnerHistoryFailed = '부여 이력을 불러오지 못했습니다.';
  static const unknownMember = '알 수 없는 회원';
  static const previousPage = '이전 페이지';
  static const nextPage = '다음 페이지';

  static String pageIndicator(int page, int totalPages) =>
      '$page / $totalPages';

  /// 이력 한 줄의 보조 설명: "별 (123)" 다음 줄에 "S2 · 2026-09-30"
  static String winnerSubtitle({
    required String name,
    required String discordId,
    required String version,
    required String date,
  }) => '$name ($discordId)\n${version.toUpperCase()} · $date';

  static String tooLong(int max) => '$max자 이하로 입력하세요.';
  static String itemLimit(int max) => '$max개까지 추가할 수 있습니다.';

  /// 브라우저 현지 시각 `yyyy-MM-dd HH:mm`
  static String formatDateTime(DateTime time) {
    String two(int value) => value.toString().padLeft(2, '0');
    return '${time.year}-${two(time.month)}-${two(time.day)} '
        '${two(time.hour)}:${two(time.minute)}';
  }
}
