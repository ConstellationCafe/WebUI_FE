import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_category_section.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';

import '../constants/shadowverse_strings.dart';

class ShadowverseCategory extends ConsumerWidget {
  static const _friendlyMatchIcon =
      'assets/icons/modules/shadowverse/friendly_match.svg';

  const ShadowverseCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuCategorySection(
      title: ShadowverseStrings.menuTitle,
      storageKey: 'shadowverse',
      children: [
        MenuContainer(
          iconImage: SvgPicture.asset(_friendlyMatchIcon, fit: BoxFit.contain),
          menuName: ShadowverseStrings.friendlyMatchMenu,
          callbackUrl: '/friendly_match',
        ),
        const SizedBox(height: ConstSize.smallSpacing),
      ],
    );
  }
}
