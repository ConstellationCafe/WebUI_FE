import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_color.dart';
import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/home_footer.dart';
import '../widgets/home_header.dart';
import '../widgets/menu_bar_area/main_menu_bar.dart';
import '../widgets/drawer/home_drawer.dart';

class HomeFrame extends ConsumerWidget {
  final Widget? child;

  const HomeFrame({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = ScreenWidth.isDesktop(width);

    final theme = Theme.of(context);

    return Scaffold(
      drawer: isDesktop
          ? null
          : const HomeDrawer(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(
          ConstPadding.largePadding,
          ConstPadding.largePadding,
          ConstPadding.largePadding,
          0,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ConstColor.gradientStart,
              ConstColor.gradientEnd,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(isDesktop: isDesktop),
            const SizedBox(
              height: ConstPadding.tinyPadding,
            ),
            Divider(
              thickness: 1,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(
              height: ConstPadding.tinyPadding,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isDesktop) ...[
                    MainMenuBar(),
                    const SizedBox(
                      width: ConstPadding.smallPadding,
                    ),
                  ],
                  Expanded(
                    child: Center(
                      child: child!,
                    ),
                  )
                ],
              ),
            ),
            HomeFooter(),
          ],
        ),
      ),
    );
  }
}