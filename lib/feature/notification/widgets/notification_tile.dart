import 'package:flutter/material.dart';

import '../constants/notification_strings.dart';
import '../constants/notification_tokens.dart';
import '../domain/model/app_notification.dart';
import '../domain/type/notification_category.dart';
import 'notification_time_format.dart';

String notificationCategoryLabel(NotificationCategory category) {
  return switch (category) {
    NotificationCategory.announcement => NotificationStrings.announcement,
    NotificationCategory.event => NotificationStrings.event,
    NotificationCategory.point => NotificationStrings.point,
    NotificationCategory.system => NotificationStrings.system,
  };
}

IconData notificationCategoryIcon(NotificationCategory category) {
  return switch (category) {
    NotificationCategory.announcement => Icons.campaign_outlined,
    NotificationCategory.event => Icons.event_outlined,
    NotificationCategory.point => Icons.toll_outlined,
    NotificationCategory.system => Icons.info_outline,
  };
}

/// 알림 한 건. 이번에 새로 받은 알림은 배경색과 "새 알림" 표시(색만으로 구분하지 않음)로 드러낸다.
class NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final DateTime now;
  final VoidCallback? onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.now,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isNew = !notification.read;
    final body = notification.body.trim();
    final category = notificationCategoryLabel(notification.category);
    const newBadge = NotificationStrings.newBadge;
    final label = isNew ? '$category · $newBadge' : category;
    final time = formatNotificationTime(notification.createdAt, now);

    return Material(
      color: isNew ? NotificationTokens.unreadTileColor : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: NotificationTokens.fieldGap,
            vertical: NotificationTokens.panelGap,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(notificationCategoryIcon(notification.category)),
              const SizedBox(width: NotificationTokens.panelGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: textTheme.labelMedium),
                    const SizedBox(height: NotificationTokens.tileGap),
                    Text(
                      notification.title,
                      style: textTheme.titleSmall,
                      maxLines: NotificationTokens.tileTitleMaxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: NotificationTokens.tileGap),
                    Text(
                      body.isEmpty ? NotificationStrings.noBody : body,
                      style: textTheme.bodyMedium,
                      maxLines: NotificationTokens.tileBodyMaxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: NotificationTokens.tileGap),
                    Text(time, style: textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
