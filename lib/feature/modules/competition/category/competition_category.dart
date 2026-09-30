import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_category_section.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';

/// 대회 메뉴. 대회 매니저 역할(또는 서버장)이 있을 때만 보인다(MainCategory, competitionPermissionProvider).
class CompetitionCategory extends ConsumerWidget {
  const CompetitionCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
