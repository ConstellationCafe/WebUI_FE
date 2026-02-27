class MembershipState {
  final bool isLoading;
  final String username;
  final String? uid1;
  final String? uid2;
  final String? role;
  final String coin;
  final String? s1Data;
  final String? s2Data;
  final String? guild;
  final String joinAt;
  final String avatar;

  MembershipState({
    this.isLoading = true,
    required this.username,
    required this.uid1,
    required this.uid2,
    required this.role,
    required this.coin,
    required this.s1Data,
    required this.s2Data,
    required this.guild,
    required this.joinAt,
    required this.avatar,
  });

  MembershipState copyWith({
    String? username,
    String? uid1,
    String? uid2,
    String? role,
    String? coin,
    String? s1Data,
    String? s2Data,
    String? guild,
    String? joinAt,
    String? avatar,
  }) {
    return MembershipState(
      isLoading: false,
      username: username ?? this.username,
      uid1: uid1 ?? this.uid1,
      uid2: uid2 ?? this.uid2,
      role: role ?? this.role,
      coin: coin ?? this.coin,
      s1Data: s1Data ?? this.s1Data,
      s2Data: s2Data ?? this.s2Data,
      guild: guild ?? this.guild,
      joinAt: joinAt ?? this.joinAt,
      avatar: avatar ?? this.avatar,
    );
  }

  factory MembershipState.initial() => MembershipState(
    isLoading: true,
    username: "",
    uid1: null,
    uid2: null,
    role: null,
    coin: "0",
    s1Data: null,
    s2Data: null,
    guild: null,
    joinAt: "",
    avatar: "",
  );

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "uid1": uid1,
      "uid2": uid2,
      "role": role,
      "coin": coin,
      "s1_data": s1Data,
      "s2_data": s2Data,
      "guild": guild,
      "join_at": joinAt,
      "avatar": avatar,
    };
  }

  factory MembershipState.fromList(List<String> result) {
    return MembershipState(
      isLoading: false,
      username: result[0],
      uid1: result[1],
      uid2: result[2],
      role: result[3],
      coin: result[4],
      s1Data: result[5],
      s2Data: result[6],
      guild: result[7],
      joinAt: result[8],
      avatar: result[9],
    );
  }
}
