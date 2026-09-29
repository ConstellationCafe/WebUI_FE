import 'dart:ui';

import '../constants/notification_tokens.dart';

/// 종 아이콘 위치를 기준으로 알림 패널을 열 위치를 계산한다.
///
/// [anchor]는 메뉴 overlay 기준 종 아이콘 영역, [screenWidth]는 overlay 너비다.
/// 반환값은 `MenuController.open(position:)`에 넘기는 종 아이콘 좌상단 기준 offset이다.
/// 패널 오른쪽 끝은 종 아이콘 오른쪽에서 화면 여백만큼 안쪽에 두되, 종이 화면 가장자리에
/// 가까워도 패널이 화면 양옆 [NotificationTokens.panelScreenMargin] 안에 머물도록 보정한다.
Offset notificationPanelOffset({
  required Rect anchor,
  required double screenWidth,
}) {
  const margin = NotificationTokens.panelScreenMargin;
  final width = NotificationTokens.panelWidthFor(screenWidth);
  final preferredLeft = anchor.right - margin - width;
  final maxLeft = screenWidth - margin - width;
  final left = maxLeft < margin ? margin : preferredLeft.clamp(margin, maxLeft);
  return Offset(
    left - anchor.left,
    anchor.height + NotificationTokens.panelBelowHeaderGap,
  );
}
