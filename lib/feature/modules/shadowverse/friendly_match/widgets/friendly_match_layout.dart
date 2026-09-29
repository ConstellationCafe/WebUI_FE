import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';

import 'input_friendly_match.dart';
import 'view_friendly_match.dart';

/// 친선전 미리보기와 입력 폼 배치. 데스크톱은 나란히, 그 외에는 위아래로 둔다.
class FriendlyMatchLayout extends StatelessWidget {
  final bool isDesktop;
  final double contentWidth;
  final GlobalKey submitKey;
  final GlobalKey inputDataKey;

  const FriendlyMatchLayout({
    super.key,
    required this.isDesktop,
    required this.contentWidth,
    required this.submitKey,
    required this.inputDataKey,
  });

  @override
  Widget build(BuildContext context) {
    final children = [
      ViewFriendlyMatch(submitKey: submitKey, width: contentWidth),
      isDesktop
          ? const SizedBox(width: ConstSize.largeSpacing)
          : const SizedBox(height: ConstSize.largeSpacing),
      InputFriendlyMatch(key: inputDataKey, width: contentWidth),
    ];
    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
