import 'package:flutter/material.dart';

import '../constants/notification_strings.dart';
import '../constants/notification_tokens.dart';

/// 알림 패널 하단의 더 보기 버튼. 불러오는 중이면 진행 표시를, 실패했으면 다시 시도를 보여준다.
class NotificationLoadMore extends StatelessWidget {
  final bool isLoading;
  final bool hasError;
  final VoidCallback onPressed;

  const NotificationLoadMore({
    super.key,
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
