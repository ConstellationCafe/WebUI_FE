import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_color.dart';
import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/home_footer.dart';
import '../widgets/home_header.dart';
import '../widgets/menu_bar_area/main_menu_bar.dart';
import '../widgets/drawer/home_drawer.dart';

class HomeFrame extends StatefulWidget {
  final Widget? child;

  const HomeFrame({super.key, this.child});

  @override
  State<HomeFrame> createState() => _HomeFrameState();
}

class _HomeFrameState extends State<HomeFrame> {
  /// 헤더 아래 구분선. 알림 패널은 구분선 오른쪽 끝과 화면 끝 사이 거리만큼
  /// 구분선 아래·화면 오른쪽에서 띄운다.
  final _dividerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = ScreenWidth.isDesktop(width);

    final theme = Theme.of(context);

    return Scaffold(
      drawer: isDesktop ? null : const HomeDrawer(),
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
            colors: [ConstColor.gradientStart, ConstColor.gradientEnd],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(isDesktop: isDesktop, dividerKey: _dividerKey),
            const SizedBox(height: ConstPadding.tinyPadding),
            Divider(
              key: _dividerKey,
              thickness: 1,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: ConstPadding.tinyPadding),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isDesktop) ...[
                    MainMenuBar(),
                    const SizedBox(width: ConstPadding.smallPadding),
                  ],
                  Expanded(child: Center(child: widget.child!)),
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
