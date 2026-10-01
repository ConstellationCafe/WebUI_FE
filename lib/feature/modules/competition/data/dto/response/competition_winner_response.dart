/// 부여된 우승 칭호 한 건(`/api/competitions/winners` 응답 항목).
class CompetitionWinnerResponse {
  final String competitionName;
  final String version;
  final String winnerDiscordId;
  final String? winnerName;

  /// 대회 개최 날짜(`yyyy-MM-dd`, 한국 날짜)
  final DateTime acquisition;

  const CompetitionWinnerResponse({
    required this.competitionName,
    required this.version,
    required this.winnerDiscordId,
    required this.winnerName,
    required this.acquisition,
  });

  factory CompetitionWinnerResponse.fromJson(Map<String, dynamic> json) {
    return CompetitionWinnerResponse(
      competitionName: json['competitionName'] as String,
      version: json['version'] as String,
      winnerDiscordId: json['winnerDiscordId'] as String,
      winnerName: json['winnerName'] as String?,
      // 날짜만 있는 값이라 현지 날짜로 그대로 해석한다(UTC 변환 없음).
      acquisition: DateTime.parse(json['acquisition'] as String),
    );
  }
}

/// 부여 이력 페이지 응답.
class CompetitionWinnerPageResponse {
  final List<CompetitionWinnerResponse> items;
  final int page;
  final int totalPages;

  const CompetitionWinnerPageResponse({
    required this.items,
    required this.page,
    required this.totalPages,
  });

  factory CompetitionWinnerPageResponse.fromJson(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>;
    return CompetitionWinnerPageResponse(
      items: [
        for (final item in items)
          CompetitionWinnerResponse.fromJson(item as Map<String, dynamic>),
      ],
      page: json['page'] as int,
      totalPages: json['totalPages'] as int,
    );
  }
}
