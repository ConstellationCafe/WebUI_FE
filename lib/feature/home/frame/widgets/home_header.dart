import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/home/frame/widgets/profile/profile_menu.dart';
import 'appbar/main_app_bar.dart';


class HomeHeader extends StatelessWidget {
  final bool isDesktop;

  const HomeHeader({
    super.key,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainAppBar(
          showMenuButton: !isDesktop,
        ),
        ProfileMenu()
      ],
    );
  }
}