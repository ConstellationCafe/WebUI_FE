class UserTemplate {
  UserTemplate(
      {required this.name,
      required this.role,
      required this.guild,
      required this.s1rank,
      required this.s1grade,
      required this.s2rank,
      required this.s2grade,
      required this.s1tournamentData,
      required this.s2tournamentData,
      required this.point,
      required this.createdAt});

  // name
  final String name;

  // role
  final String role;

  // guild
  final String guild;

  // s1 rank (필요 없으면 주석 처리)
  final String s1rank;

  // s1 grade (필요 없으면 주석 처리)
  final String s1grade;

  // s2 rank (필요 없으면 주석 처리)
  final String s2rank;

  // s2 grade (필요 없으면 주석 처리)
  final String s2grade;

  // point (coin) - 별도 테이블 관리 권장
  final int point;

  // created_at (join_at)
  final DateTime createdAt;

  // s1 tournament data (text[])
  final List<String> s1tournamentData;

  // s2 tournament data (text[])
  final List<String> s2tournamentData;
}
