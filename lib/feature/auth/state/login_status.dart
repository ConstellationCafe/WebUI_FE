/// ADR-0001: 로그인은 discordId 인증만으로 완료되지 않는다.
/// [isLoggedIn]은 AccessToken이 유효한지(=discordId 인증 완료)를,
/// [roomSelected]는 그 토큰에 botId(=선택한 채팅방)가 실려 있는지를
/// 나타낸다. 채팅방을 선택해야("/auth/guild/select") [roomSelected]가
/// true가 되며, 그때부터 /api/** 접근이 허용된다.
class LoginStatus {
  final bool isLoggedIn;
  final bool roomSelected;

  const LoginStatus({required this.isLoggedIn, required this.roomSelected});

  static const loggedOut = LoginStatus(isLoggedIn: false, roomSelected: false);
}
