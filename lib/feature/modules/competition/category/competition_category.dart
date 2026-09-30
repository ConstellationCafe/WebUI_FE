import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_category_section.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';

import '../constants/competition_strings.dart';
import '../constants/competition_tokens.dart';

/// 대회 메뉴. 현재는 관리자용 대회 개최만 있어 관리자에게만 보인다(MainCategory).
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
      ],
    );
  }
}
