class UserTemplate {
  UserTemplate(
      {required this.userName,
      required this.userRole,
      required this.userRank,
      required this.userGrade,
      required this.point,
      required this.created_at});

  final String userName;
  final String userRole;
  final String userRank;
  final String userGrade;
  final int point;
  final DateTime created_at;
}
