import 'package:flutter/material.dart';

import '../constants/notification_strings.dart';

/// 발행 이력의 이전·다음 페이지 버튼.
class NotificationPagination extends StatelessWidget {
  final int page;
  final int totalPages;
  final bool enabled;
  final ValueChanged<int> onPageChanged;

  const NotificationPagination({
    super.key,
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
        Text(NotificationStrings.pageIndicator(page, totalPages)),
        IconButton(
          tooltip: NotificationStrings.nextPage,
          onPressed: canGoForward ? () => onPageChanged(page + 1) : null,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
