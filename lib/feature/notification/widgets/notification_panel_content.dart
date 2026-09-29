import 'package:flutter/material.dart';

import '../constants/notification_strings.dart';
import '../constants/notification_tokens.dart';
import '../domain/model/app_notification.dart';
import '../state/notification_center_state.dart';
import 'notification_load_more.dart';
import 'notification_message.dart';
import 'notification_tile.dart';

/// 알림 패널 본문. loading·error·empty·success와 더 보기 상태를 구분한다.
class NotificationPanelContent extends StatelessWidget {
  final NotificationCenterState state;
  final DateTime now;
  final ValueChanged<AppNotification> onSelected;
  final VoidCallback onRetry;
  final VoidCallback onLoadMore;

  const NotificationPanelContent({
    super.key,
    required this.state,
    required this.now,
    required this.onSelected,
    required this.onRetry,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isLoading && state.items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(NotificationTokens.sectionGap),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (state.hasError && state.items.isEmpty) {
      return NotificationMessage(
        message: NotificationStrings.loadFailed,
        actionLabel: NotificationStrings.retry,
        onAction: onRetry,
      );
    }
    if (state.items.isEmpty) {
      return const NotificationMessage(message: NotificationStrings.empty);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < state.items.length; index++) ...[
          NotificationTile(
            notification: state.items[index],
            now: now,
            onTap: () => onSelected(state.items[index]),
          ),
          if (index < state.items.length - 1)
            const Divider(
              height: NotificationTokens.dividerHeight,
              indent: NotificationTokens.dividerInset,
              endIndent: NotificationTokens.dividerInset,
            ),
        ],
        if (state.hasNext)
          NotificationLoadMore(
            isLoading: state.isLoadingMore,
            hasError: state.hasError,
            onPressed: onLoadMore,
          ),
      ],
    );
  }
}
