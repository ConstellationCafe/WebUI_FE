/// 관리자가 작성한 대회 공지 내용. 시각은 브라우저 현지 시각이며, 서버에는 UTC로 보낸다.
class CompetitionDraft {
  final String title;
  final String participantWay;
  final String format;
  final DateTime registrationStart;
  final DateTime registrationEnd;
  final DateTime eventStart;
  final List<CompetitionPrize> prizes;
  final List<CompetitionExtraField> extraFields;

  const CompetitionDraft({
    required this.title,
    required this.participantWay,
    required this.format,
    required this.registrationStart,
    required this.registrationEnd,
    required this.eventStart,
    this.prizes = const [],
    this.extraFields = const [],
  });
}

/// 우승 상품 한 줄. 예: rank "1등", content "치킨 기프티콘"
class CompetitionPrize {
  final String rank;
  final String content;

  const CompetitionPrize({required this.rank, required this.content});
}

/// 관리자가 추가한 입력란 한 줄. 예: key "대회 규칙", value "덱 공개 없음"
class CompetitionExtraField {
  final String key;
  final String value;

  const CompetitionExtraField({required this.key, required this.value});
}
