import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/notification/constants/notification_strings.dart';
import 'package:constellation_cafe/feature/notification/domain/model/notification_request_id.dart';
import 'package:constellation_cafe/feature/notification/widgets/notification_time_format.dart';

void main() {
  final createdAt = DateTime.utc(2026, 9, 28, 1);

  test('1분 미만은 방금 전, 1시간 미만은 분, 하루 미만은 시간으로 표시한다', () {
    final seconds = createdAt.add(const Duration(seconds: 30));
    final minutes = createdAt.add(const Duration(minutes: 59));
    final hours = createdAt.add(const Duration(hours: 23));

    expect(
      formatNotificationTime(createdAt, seconds),
      NotificationStrings.justNow,
    );
    expect(
      formatNotificationTime(createdAt, minutes),
      NotificationStrings.minutesAgo(59),
    );
    expect(
      formatNotificationTime(createdAt, hours),
      NotificationStrings.hoursAgo(23),
    );
  });

  test('하루가 지나면 사용자 지역 시간의 날짜로 표시한다', () {
    final later = createdAt.add(const Duration(days: 2));
    final local = createdAt.toLocal();
    final month = local.month.toString().padLeft(2, '0');
    final day = local.day.toString().padLeft(2, '0');

    final text = formatNotificationTime(createdAt, later);

    expect(text, startsWith('2026.$month.$day'));
  });

  test('요청 ID는 UUID v4 형식이고 매번 다르다', () {
    final pattern = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    );
    final first = newNotificationRequestId();
    final second = newNotificationRequestId();

    expect(first, matches(pattern));
    expect(second, isNot(first));
  });
}
