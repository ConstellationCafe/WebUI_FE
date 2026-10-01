import 'package:flutter/material.dart';

import 'package:constellation_cafe/shared/model/db_editor/db_column.dart';

import '../../constants/db_editor_tokens.dart';

/// 컬럼 머리글의 정렬 방향 표시. 정렬하지 않은 컬럼은 같은 너비의 빈 칸을 둔다.
class DbSortIcon extends StatelessWidget {
  final Toggle direction;

  const DbSortIcon({super.key, required this.direction});

  @override
  Widget build(BuildContext context) {
    switch (direction) {
      case Toggle.asc:
        return const Icon(
          Icons.arrow_upward,
          size: DbEditorTokens.sortIconSize,
        );
      case Toggle.desc:
        return const Icon(
          Icons.arrow_downward,
          size: DbEditorTokens.sortIconSize,
        );
      case Toggle.none:
        return const SizedBox(width: DbEditorTokens.sortIconSize);
    }
  }
}
