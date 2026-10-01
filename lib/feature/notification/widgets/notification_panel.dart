import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/notification_strings.dart';
import '../constants/notification_tokens.dart';
import '../domain/model/app_notification.dart';
import '../notifier/notification_center_notifier.dart';
import 'notification_panel_content.dart';

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
    final width = NotificationTokens.panelWidthFor(
      MediaQuery.sizeOf(context).width,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(NotificationTokens.panelRadius),
      child: SizedBox(
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
            const Divider(
              height: NotificationTokens.dividerHeight,
              indent: NotificationTokens.dividerInset,
              endIndent: NotificationTokens.dividerInset,
            ),
            NotificationPanelContent(
              state: state,
              now: clock(),
              onSelected: onSelected,
              onRetry: notifier.loadFirstPage,
              onLoadMore: notifier.loadMore,
            ),
          ],
        ),
      ),
    );
  }
}
