import 'package:flutter/material.dart';

import '../constants/notification_tokens.dart';

/// 종 아이콘의 우측 하단에 걸치는 읽지 않은 알림 표시. [Stack]의 직계 자식으로 쓴다.
class NotificationUnreadDot extends StatelessWidget {
  const NotificationUnreadDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: NotificationTokens.unreadDotOffset,
      bottom: NotificationTokens.unreadDotOffset,
      child: Container(
        key: const ValueKey('notification-unread-dot'),
        width: NotificationTokens.unreadDotSize,
        height: NotificationTokens.unreadDotSize,
        decoration: BoxDecoration(
          color: NotificationTokens.unreadDotColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: NotificationTokens.unreadDotBorder,
          ),
        ),
      ),
    );
  }
}
