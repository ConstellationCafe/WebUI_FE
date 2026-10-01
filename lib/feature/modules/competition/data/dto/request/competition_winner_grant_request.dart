/// `POST /api/competitions/winners` 본문.
class CompetitionWinnerGrantRequest {
  final String competitionName;

  /// `GameVersionType`의 값(예: `s2`)
  final String version;
  final String winnerDiscordId;

  /// 대회 개최 날짜. 시각이 아니라 날짜라 UTC로 바꾸지 않고 `yyyy-MM-dd`로 보낸다.
  final DateTime acquisition;

  const CompetitionWinnerGrantRequest({
    required this.competitionName,
    required this.version,
    required this.winnerDiscordId,
    required this.acquisition,
  });

  Map<String, dynamic> toJson() => {
    'competitionName': competitionName.trim(),
    'version': version,
    'winnerDiscordId': winnerDiscordId.trim(),
    'acquisition': _date(acquisition),
  };

  static String _date(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year.toString().padLeft(4, '0')}-$month-$day';
  }
}
