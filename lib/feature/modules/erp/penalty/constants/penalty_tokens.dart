import 'package:flutter/material.dart';

class PenaltyTokens {
  static const gap = 16.0;
  static const fieldGap = 16.0;
  static const padding = 20.0;
  static const cardPadding = 16.0;
  static const cardGap = 8.0;
  static const breakpoint = 850.0;
  static const listWidth = 330.0;

  /// 이력 검색 필드 너비.
  static const historyFilterFieldWidth = 200.0;
  static const historySortFieldWidth = 160.0;

  /// breakpoint보다 좁은 화면에서 순위 목록과 상세를 세로로 쌓을 때의 높이.
  static const compactRankingListHeight = 350.0;
  static const compactRankingDetailHeight = 520.0;

  static const dialogWidth = 390.0;

  /// 벌점 발생 시각을 고를 수 있는 과거 범위
  static const occurredAtRange = Duration(days: 365);
  static const progressIndicatorSize = 18.0;
  static const progressIndicatorStrokeWidth = 2.0;

  static const reasonTextSize = 18.0;
  static const metadataTextSize = 12.0;
  static const cumulativeScoreTextSize = 26.0;
  static const compactScoreTextSize = 17.0;

  static const scoreBadgeHorizontalPadding = 12.0;
  static const scoreBadgeVerticalPadding = 8.0;
  static const compactScoreBadgeHorizontalPadding = 10.0;
  static const compactScoreBadgeVerticalPadding = 6.0;
  static const scoreBadgeRadius = 12.0;
  static const statusRadius = 20.0;
  static const statusHorizontalPadding = 8.0;
  static const statusVerticalPadding = 4.0;

  static const tabBarRadius = 10.0;

  /// 탭 배경 안쪽 상하 여백. 좌우에는 두지 않아 탭 영역이 아래 TabBarView와 같은 너비가 된다.
  static const tabBarInset = 4.0;
  static const headerToTabsGap = 24.0;
  static const tabHeight = 40.0;
  static const cancelButtonHeight = 36.0;
  static const cancelButtonIconSize = 16.0;
  static const cancelButtonHorizontalPadding = 12.0;
  static const cancelButtonVerticalPadding = 6.0;
  static const rankingListTileRadius = 10.0;

  static const Color metadataColor = Color(0xFF607086);
  static const Color scoreBadgeBackground = Color(0xFFEAF1F8);
  static const Color scoreBadgeForeground = Color(0xFF365778);
  static const Color activeStatusBackground = Color(0xFFE8F5E9);
  static const Color activeStatusForeground = Color(0xFF256B35);
  static const Color canceledStatusBackground = Color(0xFFFFF1F2);
  static const Color canceledStatusForeground = Color(0xFFB42318);
  static const Color tabBarBackground = Color(0xFFF0F3F7);
  static const Color tabBarActiveBackground = Color(0xFF526F8C);
  static const Color tabBarActiveForeground = Color(0xFFFFFFFF);
  static const Color tabBarInactiveForeground = Color(0xFF40566D);
  static const Color selectedListBackground = Color(0xFFEAF1F8);
}
