/// `GET /api/me/module-configs`의 메뉴용 설정. 설정 원문은 서버에 남는다.
class ModuleConfigResponse {
  final String moduleId;
  final List<String> addOns;

  const ModuleConfigResponse({required this.moduleId, required this.addOns});

  factory ModuleConfigResponse.fromJson(Map<String, dynamic> json) =>
      ModuleConfigResponse(
        moduleId: json['moduleId'] as String,
        addOns: (json['addOns'] as List<dynamic>)
            .map((value) => value as String)
            .toList(),
      );
}
