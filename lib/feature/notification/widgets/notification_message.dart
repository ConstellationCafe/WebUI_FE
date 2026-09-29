import 'package:flutter/material.dart';

import '../constants/notification_tokens.dart';

/// 알림 패널의 빈 상태·오류 안내. [actionLabel]이 있으면 아래에 버튼을 둔다.
class NotificationMessage extends StatelessWidget {
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const NotificationMessage({
    super.key,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

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
