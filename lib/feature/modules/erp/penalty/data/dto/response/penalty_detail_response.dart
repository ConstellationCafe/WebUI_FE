import 'penalty_history_response.dart';
import 'penalty_page_response.dart';

class PenaltyDetailResponse {
  final String discordId;
  final String username;
  final String state;
  final int cumulativeScore30d;
  final PenaltyPageResponse<PenaltyHistoryResponse> history;

  const PenaltyDetailResponse({
    required this.discordId,
    required this.username,
    required this.state,
    required this.cumulativeScore30d,
    required this.history,
  });

  factory PenaltyDetailResponse.fromJson(Map<String, dynamic> json) =>
      PenaltyDetailResponse(
        discordId: json['discordId'] as String,
        username: json['username'] as String,
        state: json['state'] as String,
        cumulativeScore30d: (json['cumulativeScore30d'] as num).toInt(),
        history: PenaltyPageResponse.fromJson(
          json['history'] as Map<String, dynamic>,
          PenaltyHistoryResponse.fromJson,
        ),
      );
}
