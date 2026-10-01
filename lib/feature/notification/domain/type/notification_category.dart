/// 알림 분류. Backend 계약 값(`ANNOUNCEMENT` 등)과 1:1로 대응한다.
enum NotificationCategory {
  announcement,
  event,
  point,
  system;

  String get apiValue => name.toUpperCase();

  /// 모르는 값이 오면(Backend가 먼저 배포된 경우 등) 화면이 깨지지 않도록 system으로 본다.
  static NotificationCategory fromApi(String value) {
    for (final category in values) {
      if (category.apiValue == value) return category;
    }
    return NotificationCategory.system;
  }
}
