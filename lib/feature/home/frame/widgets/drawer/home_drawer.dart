import 'package:flutter/material.dart';

import '../../../../../core/constants/const_padding.dart';
import '../../../constants/home_constants.dart';
import '../menu_bar_area/main_menu_bar.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: HomeConstants.drawerWidth,
      child: Drawer(
        child: Padding(
          padding: ConstPadding.largePaddingAll,
          child: MainMenuBar(),
        ),
      ),
    );
  }
}