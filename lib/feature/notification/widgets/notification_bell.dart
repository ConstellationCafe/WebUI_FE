import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/notification_strings.dart';
import '../constants/notification_tokens.dart';
import '../domain/model/app_notification.dart';
import '../notifier/notification_center_notifier.dart';
import 'notification_panel.dart';
import 'notification_panel_position.dart';
import 'notification_unread_dot.dart';

/// 헤더 우측 상단 프로필 아이콘 왼쪽의 종 아이콘.
///
/// 읽지 않은 알림이 있으면 우측 하단에 빨간 점을 표시한다. 누르면 알림 패널이 열리고,
/// 패널이 최신 알림을 읽음 처리하면 빨간 점이 사라진다. 색만으로 의미를 전달하지 않도록
/// 스크린 리더에는 읽지 않은 개수를 함께 알린다.
class NotificationBell extends ConsumerStatefulWidget {
  const NotificationBell({super.key});

  @override
  ConsumerState<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends ConsumerState<NotificationBell> {
  final _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    final unreadCount = ref.watch(
      notificationCenterProvider.select((state) => state.unreadCount),
    );
    final hasUnread = unreadCount > 0;
    var tooltip = NotificationStrings.bellTooltip;
    if (hasUnread) {
      tooltip = NotificationStrings.unreadCount(unreadCount);
    }

    return MenuAnchor(
      controller: _menuController,
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.primary,
        ),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(NotificationTokens.panelRadius),
          ),
        ),
      ),
      onOpen: _onOpen,
      onClose: _onClose,
      menuChildren: [
        NotificationPanel(onSelected: _onSelected, onClose: _close),
      ],
      // tooltip이 접근성 이름이 된다. 읽지 않은 알림이 있으면 개수를 함께 읽어 준다.
      child: IconButton(
        key: const ValueKey('notification-bell'),
        tooltip: tooltip,
        onPressed: _toggle,
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(
              Icons.notifications_none,
              size: NotificationTokens.bellIconSize,
            ),
            if (hasUnread) const NotificationUnreadDot(),
          ],
        ),
      ),
    );
  }

  void _toggle() {
    if (_menuController.isOpen) {
      _menuController.close();
    } else {
      _menuController.open(position: _panelPosition());
    }
  }

  /// 종 아이콘의 실제 위치로 패널 위치를 정한다. 헤더에서 종 오른쪽에 프로필 아이콘이
  /// 있어도 좁은 화면에서 패널이 화면 밖으로 밀리지 않게 하기 위해서다.
  Offset? _panelPosition() {
    final bell = context.findRenderObject();
    final overlay = Overlay.maybeOf(context)?.context.findRenderObject();
    if (bell is! RenderBox || overlay is! RenderBox) return null;
    if (!bell.hasSize || !overlay.hasSize) return null;
    final topLeft = bell.localToGlobal(Offset.zero, ancestor: overlay);
    return notificationPanelOffset(
      anchor: topLeft & bell.size,
      screenWidth: overlay.size.width,
    );
  }

  void _close() => _menuController.close();

  void _onOpen() {
    ref.read(notificationCenterProvider.notifier).openPanel();
  }

  void _onClose() {
    if (!mounted) return;
    try {
      ref.read(notificationCenterProvider.notifier).closePanel();
    } on StateError {
      // 헤더가 사라지면서(로그아웃 등) 메뉴가 닫힐 때는 provider도 함께 정리된다.
    }
  }

  void _onSelected(AppNotification notification) {
    final link = notification.link;
    _close();
    // 서버가 앱 내부 경로만 허용하지만, 화면에서도 외부 URL로 이동하지 않게 한 번 더 확인한다.
    if (link != null && link.startsWith('/') && !link.startsWith('//')) {
      context.go(link);
    }
  }
}
