import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_category_section.dart';
import 'package:constellation_cafe/feature/notification/constants/notification_strings.dart';
import 'package:constellation_cafe/feature/notification/constants/notification_tokens.dart';

class ErpCategory extends ConsumerWidget {
  const ErpCategory({super.key});

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    return MenuCategorySection(
      title: 'ERP 메뉴',
      storageKey: 'erp',
      children: [
        MenuContainer(
          iconImage: SvgPicture.asset(
            "assets/icons/modules/erp/point.svg",
            fit: BoxFit.contain,
          ),
          menuName: "포인트 관리",
          callbackUrl: "/point",
        ),
        SizedBox(height: ConstSize.tinyWidth),
        MenuContainer(
          iconImage: SvgPicture.asset(
            "assets/icons/modules/erp/penalty.svg",
            fit: BoxFit.contain,
          ),
          menuName: "벌점 관리",
          callbackUrl: "/penalties",
        ),
        const SizedBox(height: ConstSize.tinySpacing),
        MenuContainer(
          iconImage: const Icon(
            Icons.notifications_active_outlined,
            size: NotificationTokens.menuIconSize,
          ),
          menuName: NotificationStrings.adminMenu,
          callbackUrl: "/notification",
        ),
      ],
    );
  }
}
