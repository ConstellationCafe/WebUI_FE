import 'package:flutter/material.dart';

import '../constants/notification_strings.dart';
import '../constants/notification_tokens.dart';
import '../domain/model/sent_notification.dart';
import 'sent_notification_card.dart';

/// 발행 이력 본문. loading·error·empty·success를 구분한다.
class SentNotificationListBody extends StatelessWidget {
  final List<SentNotification> items;
  final bool isLoading;
  final bool hasError;
  final VoidCallback onRetry;

  const SentNotificationListBody({
    super.key,
    required this.items,
    required this.isLoading,
    required this.hasError,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(NotificationTokens.sectionGap),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (hasError) {
      return Column(
        children: [
          const Text(NotificationStrings.historyFailed),
          const SizedBox(height: NotificationTokens.panelGap),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text(NotificationStrings.retry),
          ),
        ],
      );
    }
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(NotificationTokens.sectionGap),
        child: Center(child: Text(NotificationStrings.noHistory)),
      );
    }
    // 카드를 이력 영역 너비에 맞춰 늘려, "발행 이력" 제목과 같은 왼쪽 선에서 시작하게 한다.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final item in items) ...[
          SentNotificationCard(item: item),
          const SizedBox(height: NotificationTokens.panelGap),
        ],
      ],
    );
  }
}
