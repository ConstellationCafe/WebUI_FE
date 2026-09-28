import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';
import '../../../home/frame/widgets/menu_bar_area/categories/container/menu_category_section.dart';

class ShadowverseCategory extends ConsumerWidget {
  const ShadowverseCategory({super.key});

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    return MenuCategorySection(
      title: '섀도우버스 메뉴',
      storageKey: 'shadowverse',
      children: [
        MenuContainer(
          iconImage: SvgPicture.asset(
            "assets/icons/modules/shadowverse/friendly_match.svg",
            fit: BoxFit.contain,
          ),
          menuName: "친선전",
          callbackUrl: "/friendly_match",
        ),
        SizedBox(height: ConstSize.smallSpacing),
      ],
    );
  }
}
