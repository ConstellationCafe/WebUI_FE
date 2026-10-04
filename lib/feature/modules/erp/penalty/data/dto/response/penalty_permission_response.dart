/// `GET /api/penalties/me/permissions` 응답.
class PenaltyPermissionResponse {
  /// 운영 매니저·운영 본부원 역할(또는 서버장)이 있어 벌점을 관리할 수 있는지
  final bool manager;

  const PenaltyPermissionResponse({required this.manager});

  factory PenaltyPermissionResponse.fromJson(Map<String, dynamic> json) {
    return PenaltyPermissionResponse(manager: json['manager'] as bool);
  }
}
