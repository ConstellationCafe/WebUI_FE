import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_category_section.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';
import 'package:constellation_cafe/feature/notification/constants/notification_strings.dart';
import 'package:constellation_cafe/feature/notification/constants/notification_tokens.dart';
import 'package:constellation_cafe/shared/domain/user/user_role.dart';

import '../constants/erp_strings.dart';
import '../penalty/notifier/penalty_permission_notifier.dart';

/// ERP 메뉴. 기능마다 필요한 권한이 다르다.
///
/// - 포인트 관리·알림 발행: 서버장(ADMIN)
/// - 벌점 관리: 운영 매니저·운영 본부원 역할 또는 서버장(penaltyPermissionProvider)
///
/// 권한에 맞는 기능이 하나도 없으면 카테고리째 숨긴다. 최종 판단은 서버가 한다.
class ErpCategory extends ConsumerWidget {
  static const _pointIcon = 'assets/icons/modules/erp/point.svg';
  static const _penaltyIcon = 'assets/icons/modules/erp/penalty.svg';

  const ErpCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(
      currentUserStateProvider.select(
        (state) => state.roles.contains(UserRole.admin),
      ),
    );
    final penaltyManager = ref.watch(
      penaltyPermissionProvider.select((state) => state.isManager),
    );
    final canManagePenalty = isAdmin || penaltyManager;
    final menus = <Widget>[
      if (isAdmin)
        MenuContainer(
          iconImage: SvgPicture.asset(_pointIcon, fit: BoxFit.contain),
          menuName: ErpStrings.pointMenu,
          callbackUrl: '/point',
        ),
      if (canManagePenalty)
        MenuContainer(
          iconImage: SvgPicture.asset(_penaltyIcon, fit: BoxFit.contain),
          menuName: ErpStrings.penaltyMenu,
          callbackUrl: '/penalties',
        ),
      if (isAdmin)
        const MenuContainer(
          iconImage: Icon(
            Icons.notifications_active_outlined,
            size: NotificationTokens.menuIconSize,
          ),
          menuName: NotificationStrings.adminMenu,
          callbackUrl: '/notification',
        ),
    ];
    if (menus.isEmpty) return const SizedBox.shrink();
    return MenuCategorySection(
      title: ErpStrings.menuTitle,
      storageKey: 'erp',
      children: [
        for (final (index, menu) in menus.indexed) ...[
          if (index > 0) const SizedBox(height: ConstSize.tinySpacing),
          menu,
        ],
      ],
    );
  }
}
