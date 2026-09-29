/// 회원증 정보.
class Membership {
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

  const Membership({
    required this.username,
    this.uid1,
    this.uid2,
    this.role,
    required this.coin,
    this.s1Data,
    this.s2Data,
    this.guild,
    required this.joinAt,
    required this.avatar,
  });

  /// UID 길이로 게임 버전을 구분한다. 9자리는 섀도우버스(s1), 그 밖은 섀도우버스 WB(s2).
  static String gameVersionOfUid(String uid) =>
      uid.length == s1UidLength ? 's1' : 's2';

  static const s1UidLength = 9;

  /// 길드는 섀도우버스 WB(s2)에만 있다.
  static const guildGameVersion = 's2';
}
