import 'package:flutter/material.dart';

/// DB 편집기의 크기·간격 token.
abstract final class DbEditorTokens {
  static const double shadowBlur = 24.0;
  static const Offset shadowOffset = Offset(0, 8);
  static const double editorWidth = 500.0;
  static const double editorMaxHeight = 500.0;
  static const double editorRadius = 10.0;
  static const double rowHeight = 40.0;
  static const double cellPadding = 4.0;
  static const double headerHeight = 40.0;
  static const double headerHorizontalPadding = 4.0;
  static const double sortIconSize = 14.0;
  static const double sortIconGap = 3.0;
  static const double borderWidth = 1.0;
  static const double searchBarHeight = 45.0;
  static const double searchColumnWidth = 130.0;
  static const double searchFieldHorizontalPadding = 10.0;
  static const double searchFieldVerticalPadding = 8.0;
  static const double searchGap = 8.0;
  static const double searchButtonGap = 4.0;
  static const double toolbarSpacing = 8.0;
  static const double toolButtonMinHeight = 30.0;
  static const double toolButtonHorizontalPadding = 12.0;
  static const double toolButtonLoadingSize = 18.0;

  /// 목록 끝에서 이만큼 남았을 때 다음 페이지를 미리 불러온다.
  static const double loadMoreThreshold = 200.0;
  static const int pageSize = 20;
}
