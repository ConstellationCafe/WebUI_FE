/// `GET /api/competitions/me/permissions` 응답.
class CompetitionPermissionResponse {
  /// 대회 매니저 역할(또는 서버장)이 있어 대회 기능을 쓸 수 있는지
  final bool manager;

  const CompetitionPermissionResponse({required this.manager});

  factory CompetitionPermissionResponse.fromJson(Map<String, dynamic> json) {
    return CompetitionPermissionResponse(manager: json['manager'] as bool);
  }
}
