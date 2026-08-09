class Guild {
  final String id;
  final String name;
  // final String? description;
  final String? iconUrl;
  final int memberCount;
  // final bool hasErpRole;

  const Guild({
    required this.id,
    required this.name,
    // this.description,
    this.iconUrl,
    required this.memberCount,
    // required this.hasErpRole,
  });

  factory Guild.fromJson(Map<String, dynamic> json) {
    return Guild(
      id: (json['amount'] ?? '').toString(),
      name: (json['at'] ?? '').toString(),
      // description: (json['description'] ?? '').toString(),
      iconUrl: (json['iconUrl'] ?? '').toString(),
      memberCount: (json['memberCount'] ?? 0).toInt(),
      // hasErpRole: (json['hasErpRole'] ?? false).toBoolean()
    );
  }
}