import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/notification_strings.dart';
import '../constants/notification_tokens.dart';
import '../domain/model/app_notification.dart';
import '../notifier/notification_center_notifier.dart';
import '../state/notification_center_state.dart';
import 'notification_tile.dart';

/// 종 아이콘을 누르면 열리는 알림 목록. loading·error·empty·success와
/// 더 보기 로딩을 각각 다르게 보여준다.
///
/// MenuAnchor의 메뉴 패널은 자식의 intrinsic 너비를 계산하고 자체 스크롤을 가지므로,
/// 여기서는 lazy list(ListView)나 LayoutBuilder 대신 고정 너비와 Column을 쓴다.
/// 한 번에 보이는 알림은 한 페이지(20건)로 제한된다.
class NotificationPanel extends ConsumerWidget {
  final ValueChanged<AppNotification> onSelected;
  final VoidCallback onClose;
  final DateTime Function() clock;

  const NotificationPanel({
    super.key,
    required this.onSelected,
    required this.onClose,
    this.clock = DateTime.now,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationCenterProvider);
    final notifier = ref.read(notificationCenterProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final available = screenWidth - NotificationTokens.panelScreenMargin * 2;
    final width = max(0.0, min(NotificationTokens.panelWidth, available));

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              NotificationTokens.fieldGap,
              NotificationTokens.panelGap,
              NotificationTokens.panelGap,
              NotificationTokens.panelGap,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text(
                      NotificationStrings.panelTitle,
                      style: textTheme.titleMedium,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: NotificationStrings.close,
                  onPressed: onClose,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _content(state, notifier),
        ],
      ),
    );
  }

  Widget _content(
    NotificationCenterState state,
    NotificationCenterNotifier notifier,
  ) {
    if (state.isLoading && state.items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(NotificationTokens.sectionGap),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (state.hasError && state.items.isEmpty) {
      return _Message(
        message: NotificationStrings.loadFailed,
        actionLabel: NotificationStrings.retry,
        onAction: notifier.loadFirstPage,
      );
    }
    if (state.items.isEmpty) {
      return const _Message(message: NotificationStrings.empty);
    }
    final now = clock();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final notification in state.items) ...[
          NotificationTile(
            notification: notification,
            now: now,
            onTap: () => onSelected(notification),
          ),
          const Divider(height: 1),
        ],
        if (state.hasNext)
          _LoadMore(
            isLoading: state.isLoadingMore,
            hasError: state.hasError,
            onPressed: notifier.loadMore,
          ),
      ],
    );
  }
}

class _LoadMore extends StatelessWidget {
  final bool isLoading;
  final bool hasError;
  final VoidCallback onPressed;

  const _LoadMore({
    required this.isLoading,
    required this.hasError,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(NotificationTokens.panelGap),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    const retry = NotificationStrings.retry;
    const more = NotificationStrings.loadMore;
    return Padding(
      padding: const EdgeInsets.all(NotificationTokens.panelGap),
      child: Center(
        child: TextButton(
          onPressed: onPressed,
          child: Text(hasError ? retry : more),
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _Message({required this.message, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    final label = actionLabel;
    return Padding(
      padding: const EdgeInsets.all(NotificationTokens.sectionGap),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, textAlign: TextAlign.center),
          if (label != null) ...[
            const SizedBox(height: NotificationTokens.panelGap),
            ElevatedButton(onPressed: onAction, child: Text(label)),
          ],
        ],
      ),
    );
  }
}
