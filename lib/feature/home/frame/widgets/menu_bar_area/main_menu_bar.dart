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
        padding: const EdgeInsets.only(bottom: HomeConstants.menuBottomPadding),
        child: const MainCategory(),
      ),
    );
  }
}
