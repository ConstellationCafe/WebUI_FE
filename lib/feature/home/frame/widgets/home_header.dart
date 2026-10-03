import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/home/frame/widgets/profile/profile_menu.dart';
import 'package:constellation_cafe/feature/notification/constants/notification_tokens.dart';
import 'package:constellation_cafe/feature/notification/widgets/notification_bell.dart';
import 'appbar/main_app_bar.dart';

class HomeHeader extends StatelessWidget {
  final bool isDesktop;

  /// 알림 패널 위치의 기준이 되는 헤더 아래 구분선
  final GlobalKey? dividerKey;

  const HomeHeader({super.key, required this.isDesktop, this.dividerKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainAppBar(showMenuButton: !isDesktop),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NotificationBell(dividerKey: dividerKey),
            const SizedBox(width: NotificationTokens.bellGap),
            ProfileMenu(),
          ],
        ),
      ],
    );
  }
}
