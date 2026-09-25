import 'admin_point_log_response.dart';

class AdminPointDetailResponse {
  final String discordId;
  final String? username;
  final String state;
  final int coin;
  final List<AdminPointLogResponse> logs;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;
  final bool hasNext;

  const AdminPointDetailResponse({
    required this.discordId,
    required this.username,
    required this.state,
    required this.coin,
    required this.logs,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.hasNext,
  });

  factory AdminPointDetailResponse.fromJson(Map<String, dynamic> json) {
    return AdminPointDetailResponse(
      discordId: json['discordId'] as String,
      username: json['username'] as String?,
      state: json['state'] as String,
      coin: (json['coin'] as num).toInt(),
      logs: (json['logs'] as List<dynamic>)
          .map(
            (item) =>
                AdminPointLogResponse.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      totalElements: (json['totalElements'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
    );
  }
}
