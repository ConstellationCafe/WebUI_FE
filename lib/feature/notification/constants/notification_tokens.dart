import 'package:flutter/material.dart';

/// 알림 기능 전용 디자인 상수. 공통 값은 core/constants를 사용한다.
class NotificationTokens {
  // 종 아이콘
  static const bellSize = 40.0;
  static const bellIconSize = 26.0;
  static const bellGap = 8.0;
  static const unreadDotSize = 10.0;
  static const unreadDotBorder = 2.0;
  static const unreadDotOffset = -2.0;
  static const unreadDotColor = Color(0xFFE53935);

  // 알림 패널
  static const panelWidth = 360.0;
  static const panelScreenMargin = 16.0;
  static const panelBelowHeaderGap = 20.0;

  /// 본문 영역 우측 상단에 패널을 둘 때 위쪽·오른쪽 벽과의 같은 간격
  static const panelAreaInset = 16.0;
  static const panelRadius = 12.0;
  static const panelGap = 8.0;
  static const dividerInset = 16.0;
  static const dividerHeight = 12.0;
  static const tileGap = 4.0;
  static const unreadTileColor = Color(0xFFEAF1FB);

  // 관리자 발행 화면
  static const menuIconSize = 20.0;
  static const fieldGap = 16.0;
  static const sectionGap = 24.0;
  static const formMaxWidth = 560.0;
  static const compactBreakpoint = 960.0;
  static const bodyMaxLines = 6;
  static const tileTitleMaxLines = 2;
  static const tileBodyMaxLines = 3;
  static const progressSize = 18.0;
  static const progressStroke = 2.0;

  static double panelWidthFor(double screenWidth) {
    final available = screenWidth - panelScreenMargin * 2;
    if (available <= 0) return 0;
    return available < panelWidth ? available : panelWidth;
  }
}
