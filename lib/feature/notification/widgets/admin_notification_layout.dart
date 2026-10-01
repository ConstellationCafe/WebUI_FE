import 'package:flutter/material.dart';

import '../constants/notification_tokens.dart';

/// 관리자 알림 화면 배치. 넓은 화면은 작성 폼과 발행 이력을 나란히, 좁은 화면은 위아래로 둔다.
class AdminNotificationLayout extends StatelessWidget {
  final bool isCompact;
  final Widget form;
  final Widget history;

  const AdminNotificationLayout({
    super.key,
    required this.isCompact,
    required this.form,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          form,
          const SizedBox(height: NotificationTokens.sectionGap),
          history,
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: NotificationTokens.formMaxWidth,
          ),
          child: form,
        ),
        const SizedBox(width: NotificationTokens.sectionGap),
        Expanded(child: history),
      ],
    );
  }
}
