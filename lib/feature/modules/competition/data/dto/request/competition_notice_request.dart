/// `POST /api/admin/competitions/preview` 본문이자 게시 요청의 `notice`.
/// 시각은 공통 규칙대로 UTC ISO-8601로 보낸다. 서버가 게시글에는 한국 시간으로 적는다.
class CompetitionNoticeRequest {
  final String title;
  final String participantWay;
  final String format;
  final DateTime registrationStart;
  final DateTime registrationEnd;
  final DateTime eventStart;
  final List<CompetitionPrizeRequest> prizes;
  final List<CompetitionExtraFieldRequest> extraFields;

  const CompetitionNoticeRequest({
    required this.title,
    required this.participantWay,
    required this.format,
    required this.registrationStart,
    required this.registrationEnd,
    required this.eventStart,
    required this.prizes,
    required this.extraFields,
  });

  Map<String, dynamic> toJson() => {
    'title': title.trim(),
    'participantWay': participantWay.trim(),
    'format': format.trim(),
    'registrationStart': registrationStart.toUtc().toIso8601String(),
    'registrationEnd': registrationEnd.toUtc().toIso8601String(),
    'eventStart': eventStart.toUtc().toIso8601String(),
    'prizes': [for (final prize in prizes) prize.toJson()],
    'extraFields': [for (final field in extraFields) field.toJson()],
  };
}

class CompetitionPrizeRequest {
  final String rank;
  final String content;

  const CompetitionPrizeRequest({required this.rank, required this.content});

  Map<String, dynamic> toJson() => {
    'rank': rank.trim(),
    'content': content.trim(),
  };
}

class CompetitionExtraFieldRequest {
  final String key;
  final String value;

  const CompetitionExtraFieldRequest({required this.key, required this.value});

  Map<String, dynamic> toJson() => {'key': key.trim(), 'value': value.trim()};
}
