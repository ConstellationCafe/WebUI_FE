import 'dart:ui';

import '../constants/notification_tokens.dart';

/// 알림 패널을 열 위치를 계산한다.
///
/// [anchor]는 메뉴 overlay 기준 종 아이콘 영역, [screenWidth]는 overlay 너비다.
/// 반환값은 `MenuController.open(position:)`에 넘기는 종 아이콘 좌상단 기준 offset이다.
///
/// [area]가 있으면(헤더 아래 본문 영역) 패널을 그 영역의 우측 상단에 두고, 위쪽과 오른쪽
/// 벽에서 같은 [NotificationTokens.panelAreaInset]만큼 띄운다.
/// [area]가 없으면 패널 오른쪽 끝을 종 아이콘 오른쪽에서 화면 여백만큼 안쪽에 둔다.
/// 어느 경우든 패널이 화면 양옆 [NotificationTokens.panelScreenMargin] 안에 머물도록 보정한다.
Offset notificationPanelOffset({
  required Rect anchor,
  required double screenWidth,
  Rect? area,
}) {
  const margin = NotificationTokens.panelScreenMargin;
  const inset = NotificationTokens.panelAreaInset;
  final width = NotificationTokens.panelWidthFor(screenWidth);
  final preferredLeft = area == null
      ? anchor.right - margin - width
      : area.right - inset - width;
  final maxLeft = screenWidth - margin - width;
  final left = maxLeft < margin ? margin : preferredLeft.clamp(margin, maxLeft);
  final top = area == null
      ? anchor.bottom + NotificationTokens.panelBelowHeaderGap
      : area.top + inset;
  return Offset(left - anchor.left, top - anchor.top);
}
