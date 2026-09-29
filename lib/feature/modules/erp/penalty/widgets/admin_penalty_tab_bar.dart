import 'package:flutter/material.dart';

import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';

/// 벌점 이력·30일 누적 순위 탭.
///
/// 배경 안쪽 여백은 상하에만 둔다. 좌우 여백을 두면 탭 영역이 아래 TabBarView보다
/// 좁아져 선택 표시와 목록 카드의 좌우 끝선이 어긋난다.
class AdminPenaltyTabBar extends StatelessWidget {
  const AdminPenaltyTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: PenaltyTokens.tabBarInset),
      decoration: const BoxDecoration(
        color: PenaltyTokens.tabBarBackground,
        borderRadius: BorderRadius.all(
          Radius.circular(PenaltyTokens.tabBarRadius),
        ),
      ),
      child: const TabBar(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: PenaltyTokens.tabBarActiveBackground,
          borderRadius: BorderRadius.all(
            Radius.circular(PenaltyTokens.tabBarRadius),
          ),
        ),
        labelColor: PenaltyTokens.tabBarActiveForeground,
        unselectedLabelColor: PenaltyTokens.tabBarInactiveForeground,
        labelStyle: TextStyle(fontWeight: FontWeight.w700),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        tabs: [
          Tab(text: PenaltyStrings.history, height: PenaltyTokens.tabHeight),
          Tab(text: PenaltyStrings.ranking, height: PenaltyTokens.tabHeight),
        ],
      ),
    );
  }
}
