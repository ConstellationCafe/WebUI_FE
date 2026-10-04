import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';

/// 넓으면 입력란을 같은 너비로 나란히, 좁으면(모바일) 세로로 쌓는다.
///
/// 화면 폭이 아니라 실제로 받은 너비로 판단하므로 카드 안쪽 여백까지 반영된다.
/// [equalHeight]이면 나란히 놓을 때 입력란 높이를 맞춘다.
class AcademyResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final bool equalHeight;

  const AcademyResponsiveRow({
    super.key,
    required this.children,
    this.equalHeight = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < AcademyConstants.formStackBreakpoint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const SizedBox(height: ConstPadding.mediumPadding),
                children[i],
              ],
            ],
          );
        }
        final row = Row(
          crossAxisAlignment: equalHeight
              ? CrossAxisAlignment.stretch
              : CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0) const SizedBox(width: ConstPadding.mediumPadding),
              Expanded(child: children[i]),
            ],
          ],
        );
        return equalHeight ? IntrinsicHeight(child: row) : row;
      },
    );
  }
}
