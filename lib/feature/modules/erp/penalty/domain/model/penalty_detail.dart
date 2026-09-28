import 'penalty_log.dart';
import 'penalty_page.dart';

class PenaltyDetail {
  final String discordId;
  final String username;
  final String state;
  final int cumulativeScore30d;
  final PenaltyPage<PenaltyLog> history;

  const PenaltyDetail({
    required this.discordId,
    required this.username,
    required this.state,
    required this.cumulativeScore30d,
    required this.history,
  });
}
