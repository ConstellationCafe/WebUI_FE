import 'dart:ui';

import '../constants/notification_tokens.dart';

/// 알림 패널을 열 위치를 계산한다.
///
/// [anchor]는 메뉴 overlay 기준 종 아이콘 영역, [screenWidth]는 overlay 너비다.
/// 반환값은 `MenuController.open(position:)`에 넘기는 종 아이콘 좌상단 기준 offset이다.
///
/// [divider]가 있으면(홈 헤더 아래 구분선) 구분선 오른쪽 끝과 화면 오른쪽 끝 사이의 거리를
/// 간격으로 삼아, 패널을 구분선 아래로 그 간격만큼, 화면 오른쪽 끝에서 그 간격만큼 띄운다.
/// [divider]가 없으면 패널 오른쪽 끝을 종 아이콘 오른쪽에서 화면 여백만큼 안쪽에 둔다.
/// 어느 경우든 패널이 화면 양옆 [NotificationTokens.panelScreenMargin] 안에 머물도록 보정한다.
Offset notificationPanelOffset({
  required Rect anchor,
  required double screenWidth,
  Rect? divider,
}) {
  const margin = NotificationTokens.panelScreenMargin;
  final width = NotificationTokens.panelWidthFor(screenWidth);
  final gap = divider == null ? null : screenWidth - divider.right;
  final preferredLeft = gap == null
      ? anchor.right - margin - width
      : screenWidth - gap - width;
  final maxLeft = screenWidth - margin - width;
  final left = maxLeft < margin ? margin : preferredLeft.clamp(margin, maxLeft);
  final top = gap == null
      ? anchor.bottom + NotificationTokens.panelBelowHeaderGap
      : divider!.center.dy + gap;
  return Offset(left - anchor.left, top - anchor.top);
}
