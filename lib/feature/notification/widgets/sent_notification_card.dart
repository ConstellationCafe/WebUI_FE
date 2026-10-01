import 'package:flutter/material.dart';

import '../constants/notification_strings.dart';
import '../constants/notification_tokens.dart';
import '../domain/model/sent_notification.dart';
import '../domain/type/notification_target_type.dart';
import 'notification_tile.dart';
import 'notification_time_format.dart';

/// 관리자 발행 이력의 알림 한 건.
class SentNotificationCard extends StatelessWidget {
  final SentNotification item;

  const SentNotificationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final target = _targetText(item);
    final source = _sourceText(item.source);
    final category = notificationCategoryLabel(item.category);
    final time = formatNotificationDate(item.createdAt);
    final body = item.body.trim();

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(NotificationTokens.fieldGap),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              NotificationStrings.sentSummary(category, target, source),
              style: textTheme.labelMedium,
            ),
            const SizedBox(height: NotificationTokens.tileGap),
            Text(item.title, style: textTheme.titleSmall),
            const SizedBox(height: NotificationTokens.tileGap),
            Text(body.isEmpty ? NotificationStrings.noBody : body),
            const SizedBox(height: NotificationTokens.tileGap),
            Text(time, style: textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  String _targetText(SentNotification item) {
    if (item.targetType == NotificationTargetType.guild) {
      return NotificationStrings.targetGuild;
    }
    return NotificationStrings.targetUserWithId(item.targetDiscordId ?? '');
  }

  String _sourceText(String source) {
    return switch (source) {
      'ADMIN' => NotificationStrings.sourceAdmin,
      'INTERNAL' => NotificationStrings.sourceInternal,
      'EXTERNAL' => NotificationStrings.sourceExternal,
      _ => source,
    };
  }
}
