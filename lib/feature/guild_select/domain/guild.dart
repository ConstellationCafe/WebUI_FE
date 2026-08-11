class Guild {
  final String id;
  final String name;
  // final String? description;
  final String iconUrl;
  final int memberCount;
  // final bool hasErpRole;

  const Guild({
    required this.id,
    required this.name,
    // this.description,
    required this.iconUrl,
    required this.memberCount,
    // required this.hasErpRole,
  });

  factory Guild.fromJson(Map<String, dynamic> json) {
    return Guild(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      // description: (json['description'] ?? '').toString(),
      iconUrl: (json['iconUrl'] ?? '').toString(),
      memberCount: (json['memberCount'] ?? 0),
      // hasErpRole: (json['hasErpRole'] ?? false).toBoolean()
    );
  }
}