/// 알림 수신 범위. guild는 채팅방 전체, user는 한 회원.
enum NotificationTargetType {
  guild,
  user;

  String get apiValue => name.toUpperCase();

  static NotificationTargetType fromApi(String value) {
    return value == 'USER'
        ? NotificationTargetType.user
        : NotificationTargetType.guild;
  }
}
