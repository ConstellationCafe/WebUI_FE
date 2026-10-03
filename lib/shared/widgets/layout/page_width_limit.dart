import 'package:flutter/material.dart';

import '../../constants/layout_tokens.dart';

/// 기능 화면 본문의 가로 폭을 [maxWidth]로 제한하고 가운데에 둔다.
///
/// 높이 제약은 그대로 넘기므로 `Expanded`를 쓰는 화면도 감쌀 수 있다. 스크롤 화면은
/// 스크롤바가 화면 끝에 붙도록 scroll view 안쪽에서 감싼다.
class PageWidthLimit extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const PageWidthLimit({
    super.key,
    required this.child,
    this.maxWidth = LayoutTokens.pageMaxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}
