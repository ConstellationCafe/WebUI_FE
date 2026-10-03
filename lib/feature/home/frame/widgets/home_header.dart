import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/home/frame/widgets/profile/profile_menu.dart';
import 'package:constellation_cafe/feature/notification/constants/notification_tokens.dart';
import 'package:constellation_cafe/feature/notification/widgets/notification_bell.dart';
import 'appbar/main_app_bar.dart';

class HomeHeader extends StatelessWidget {
  final bool isDesktop;

  /// 알림 패널을 우측 상단에 띄울 본문 영역
  final GlobalKey? notificationAreaKey;

  const HomeHeader({
    super.key,
    required this.isDesktop,
    this.notificationAreaKey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainAppBar(showMenuButton: !isDesktop),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NotificationBell(panelAreaKey: notificationAreaKey),
            const SizedBox(width: NotificationTokens.bellGap),
            ProfileMenu(),
          ],
        ),
      ],
    );
  }
}
