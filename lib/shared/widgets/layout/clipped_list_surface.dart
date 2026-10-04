import 'package:flutter/material.dart';

/// 스크롤 목록 영역에 잘리는 Material 바탕을 깐다.
///
/// `ListTile`의 선택 배경(`selectedTileColor`)과 눌림 효과는 가장 가까운 Material
/// (예: 바깥 `Card`)에 그려진다. 그 Material이 목록보다 넓으면, 목록을 스크롤했을 때
/// 위로 올라간 항목의 배경이 목록 밖(검색창 뒤 등)에 그대로 보인다. 목록을 이
/// 위젯으로 감싸면 배경이 목록 영역 안에서만 그려진다.
class ClippedListSurface extends StatelessWidget {
  final Widget child;

  const ClippedListSurface({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.hardEdge,
      child: child,
    );
  }
}
