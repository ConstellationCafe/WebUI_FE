import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'categories/main_category.dart';
import '../../../constants/home_constants.dart';

class MainMenuBar extends ConsumerStatefulWidget {
  const MainMenuBar({super.key});

  @override
  ConsumerState<MainMenuBar> createState() => _MainMenuBarState();
}

class _MainMenuBarState extends ConsumerState<MainMenuBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: HomeConstants.menuWidth,
      child: SingleChildScrollView(
        // 오른쪽에 스크롤바 자리를 비워 메뉴 버튼과 겹치지 않게 한다.
        padding: const EdgeInsets.only(
          right: HomeConstants.menuScrollbarGutter,
          bottom: HomeConstants.menuBottomPadding,
        ),
        child: const MainCategory(),
      ),
    );
  }
}
