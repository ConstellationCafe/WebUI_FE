import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_category_section.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';
import '../notifier/competition_permission_notifier.dart';

/// 대회 메뉴. 모든 기능이 대회 매니저 역할(또는 서버장)을 요구하므로,
/// 권한이 없거나 아직 확인하지 못했으면 카테고리째 숨긴다(competitionPermissionProvider).
class CompetitionCategory extends ConsumerWidget {
  const CompetitionCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permission = ref.watch(competitionPermissionProvider);
    if (permission.isLoading ||
        !permission.isInitialized ||
        !permission.isManager) {
      return const SizedBox.shrink();
    }
    return const MenuCategorySection(
      title: CompetitionStrings.menuTitle,
      storageKey: 'competition',
      children: [
        MenuContainer(
          iconImage: Icon(
            Icons.emoji_events_outlined,
            size: CompetitionTokens.menuIconSize,
          ),
          menuName: CompetitionStrings.menu,
          callbackUrl: '/competitions',
        ),
        SizedBox(height: ConstSize.tinySpacing),
        MenuContainer(
          iconImage: Icon(
            Icons.military_tech_outlined,
            size: CompetitionTokens.menuIconSize,
          ),
          menuName: CompetitionStrings.winnerMenu,
          callbackUrl: '/competition-winners',
        ),
      ],
    );
  }
}
