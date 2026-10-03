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
    // ExpansionTile은 펼쳤을 때 아이콘·제목을 colorScheme.primary(흰색)로 칠해
    // 토글 화살표가 배경에 묻힌다. 접힘·펼침 모두 진한 secondary로 고정한다.
    final foreground = theme.colorScheme.secondary;
    return ExpansionTile(
      key: PageStorageKey<String>(storageKey),
      title: Text(title, style: theme.textTheme.titleSmall),
      initiallyExpanded: true,
      maintainState: true,
      tilePadding: const EdgeInsets.symmetric(
        horizontal: HomeConstants.menuTitleHorizontalPadding,
      ),
      childrenPadding: EdgeInsets.zero,
      iconColor: foreground,
      collapsedIconColor: foreground,
      textColor: foreground,
      collapsedTextColor: foreground,
      backgroundColor: Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      shape: const Border(),
      collapsedShape: const Border(),
      children: children,
    );
  }
}
