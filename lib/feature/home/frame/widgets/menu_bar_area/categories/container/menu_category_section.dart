import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/home/constants/home_constants.dart';

/// 메뉴를 접어도 화면을 이동한 뒤 같은 열린 상태를 유지한다.
class MenuCategorySection extends StatelessWidget {
  final String title;
  final String storageKey;
  final List<Widget> children;

  const MenuCategorySection({
    super.key,
    required this.title,
    required this.storageKey,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ExpansionTile(
      key: PageStorageKey<String>(storageKey),
      title: Text(title, style: theme.textTheme.titleSmall),
      initiallyExpanded: true,
      maintainState: true,
      tilePadding: const EdgeInsets.symmetric(
        horizontal: HomeConstants.menuTitleHorizontalPadding,
      ),
      childrenPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      shape: const Border(),
      collapsedShape: const Border(),
      children: children,
    );
  }
}
