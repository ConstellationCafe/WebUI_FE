import 'penalty_log.dart';
import 'penalty_page.dart';

class PenaltyDetail {
  final String discordId;
  final String displayName;
  final String state;
  final int cumulativeScore30d;
  final PenaltyPage<PenaltyLog> history;

  const PenaltyDetail({
    required this.discordId,
    required this.displayName,
    required this.state,
    required this.cumulativeScore30d,
    required this.history,
  });
}
