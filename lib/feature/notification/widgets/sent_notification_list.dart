import 'package:flutter/material.dart';

import '../constants/notification_strings.dart';
import '../constants/notification_tokens.dart';
import '../domain/model/sent_notification.dart';
import '../domain/type/notification_target_type.dart';
import 'notification_tile.dart';
import 'notification_time_format.dart';

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
        _body(),
        if (totalPages > 1) ...[
          const SizedBox(height: NotificationTokens.panelGap),
          _Pagination(
            page: page,
            totalPages: totalPages,
            enabled: !isLoading,
            onPageChanged: onPageChanged,
          ),
        ],
      ],
    );
  }

  Widget _body() {
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
    return Column(
      children: [
        for (final item in items) ...[
          _SentNotificationCard(item: item),
          const SizedBox(height: NotificationTokens.panelGap),
        ],
      ],
    );
  }
}

class _SentNotificationCard extends StatelessWidget {
  final SentNotification item;

  const _SentNotificationCard({required this.item});

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
            Text('$category · $target · $source', style: textTheme.labelMedium),
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
    return '${NotificationStrings.targetUser} ${item.targetDiscordId ?? ''}';
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

class _Pagination extends StatelessWidget {
  final int page;
  final int totalPages;
  final bool enabled;
  final ValueChanged<int> onPageChanged;

  const _Pagination({
    required this.page,
    required this.totalPages,
    required this.enabled,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final canGoBack = enabled && page > 1;
    final canGoForward = enabled && page < totalPages;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          tooltip: NotificationStrings.previousPage,
          onPressed: canGoBack ? () => onPageChanged(page - 1) : null,
          icon: const Icon(Icons.chevron_left),
        ),
        Text('$page / $totalPages'),
        IconButton(
          tooltip: NotificationStrings.nextPage,
          onPressed: canGoForward ? () => onPageChanged(page + 1) : null,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
