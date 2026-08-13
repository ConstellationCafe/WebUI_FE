import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'categories/main_category.dart';

class MainMenuBar extends ConsumerStatefulWidget {
  const MainMenuBar({super.key});

  @override
  ConsumerState<MainMenuBar> createState() => _MainMenuBarState();
}

class _MainMenuBarState extends ConsumerState<MainMenuBar> {
  @override
  Widget build(BuildContext build) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // MainSearchBar(),
        // SizedBox(height: 10),
        MainCategory()
      ],
    );
  }
}
