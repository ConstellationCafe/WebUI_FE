import 'package:flutter/material.dart';

import '../constants/notification_strings.dart';
import '../constants/notification_tokens.dart';
import '../domain/model/sent_notification.dart';
import 'notification_pagination.dart';
import 'sent_notification_list_body.dart';

/// 관리자 발행 이력. loading·error·empty·success를 구분해 보여준다.
class SentNotificationList extends StatelessWidget {
  final List<SentNotification> items;
  final bool isLoading;
  final bool hasError;
  final int page;
  final int totalPages;
  final VoidCallback onRetry;
  final ValueChanged<int> onPageChanged;

  const SentNotificationList({
    super.key,
    required this.items,
    required this.isLoading,
    required this.hasError,
    required this.page,
    required this.totalPages,
    required this.onRetry,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(NotificationStrings.history, style: textTheme.titleLarge),
        const SizedBox(height: NotificationTokens.fieldGap),
        SentNotificationListBody(
          items: items,
          isLoading: isLoading,
          hasError: hasError,
          onRetry: onRetry,
        ),
        if (totalPages > 1) ...[
          const SizedBox(height: NotificationTokens.panelGap),
          NotificationPagination(
            page: page,
            totalPages: totalPages,
            enabled: !isLoading,
            onPageChanged: onPageChanged,
          ),
        ],
      ],
    );
  }
}
