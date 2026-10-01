import 'package:constellation_cafe/feature/modules/shadowverse/friendly_match/domain/version/game_version_type.dart';

/// 관리자가 입력한 우승 칭호 부여 내용.
class CompetitionWinnerDraft {
  final String competitionName;
  final GameVersionType version;
  final String winnerDiscordId;

  /// 대회 개최 날짜(현지 날짜)
  final DateTime acquisition;

  const CompetitionWinnerDraft({
    required this.competitionName,
    required this.version,
    required this.winnerDiscordId,
    required this.acquisition,
  });
}

/// 부여된 우승 칭호.
class CompetitionWinner {
  final String competitionName;
  final GameVersionType version;
  final String winnerDiscordId;

  /// 현재 채팅방에서의 회원 이름. 알 수 없으면 null
  final String? winnerName;
  final DateTime acquisition;

  const CompetitionWinner({
    required this.competitionName,
    required this.version,
    required this.winnerDiscordId,
    required this.winnerName,
    required this.acquisition,
  });
}

class CompetitionWinnerPage {
  final List<CompetitionWinner> items;
  final int page;
  final int totalPages;

  const CompetitionWinnerPage({
    required this.items,
    required this.page,
    required this.totalPages,
  });
}

/// 우승 칭호 부여가 실패한 이유.
enum CompetitionWinnerFailure {
  /// 입력 검증 실패(400). 서버 안내 문구를 함께 보여준다.
  invalid,

  /// 우승자가 현재 채팅방의 재적 회원이 아님(404)
  notMember,

  /// 같은 대회·버전 칭호가 이미 부여됨(409)
  conflict,

  /// 네트워크 오류 등 결과를 알 수 없음
  unknown,
}

class CompetitionWinnerException implements Exception {
  final CompetitionWinnerFailure reason;

  /// 서버 안내 문구
  final String? message;

  const CompetitionWinnerException(this.reason, [this.message]);

  @override
  String toString() => 'CompetitionWinnerException($reason)';
}
