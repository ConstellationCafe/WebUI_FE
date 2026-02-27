class GlobalState {
  final String userId;
  final String globalName;
  final List<String> roles;
  final String avatarUrl;

  GlobalState({
    required this.userId,
    required this.globalName,
    required this.roles,
    required this.avatarUrl
  });

  factory GlobalState.initial() => GlobalState(
    userId: "",
    globalName: "",
    roles: [],
    avatarUrl: ""
  );

  GlobalState copyWith({
    String? userId,
    String? globalName,
    List<String>? roles,
    String? avatarUrl
  }) {
    return GlobalState(
      userId: userId ?? this.userId,
      globalName: globalName ?? this.globalName,
      roles: roles ?? this.roles,
      avatarUrl: avatarUrl ?? this.avatarUrl
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "globalName": globalName,
      "roles": roles,
      "avatarUrl": avatarUrl
    };
  }

  factory GlobalState.fromJson(Map<String, dynamic> json) {
    return GlobalState(
      userId: json["discordId"]?.toString() ?? '',
      globalName: json["globalName"]?.toString() ?? '',
      roles: (json["roles"] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      avatarUrl: json["avatar"],
    );
  }
}
