import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_category_section.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';
import 'package:constellation_cafe/feature/notification/constants/notification_strings.dart';
import 'package:constellation_cafe/feature/notification/constants/notification_tokens.dart';

import '../constants/erp_strings.dart';

class ErpCategory extends ConsumerWidget {
  static const _pointIcon = 'assets/icons/modules/erp/point.svg';
  static const _penaltyIcon = 'assets/icons/modules/erp/penalty.svg';

  const ErpCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuCategorySection(
      title: ErpStrings.menuTitle,
      storageKey: 'erp',
      children: [
        MenuContainer(
          iconImage: SvgPicture.asset(_pointIcon, fit: BoxFit.contain),
          menuName: ErpStrings.pointMenu,
          callbackUrl: '/point',
        ),
        const SizedBox(height: ConstSize.tinySpacing),
        MenuContainer(
          iconImage: SvgPicture.asset(_penaltyIcon, fit: BoxFit.contain),
          menuName: ErpStrings.penaltyMenu,
          callbackUrl: '/penalties',
        ),
        const SizedBox(height: ConstSize.tinySpacing),
        MenuContainer(
          iconImage: const Icon(
            Icons.notifications_active_outlined,
            size: NotificationTokens.menuIconSize,
          ),
          menuName: NotificationStrings.adminMenu,
          callbackUrl: '/notification',
        ),
      ],
    );
  }
}
