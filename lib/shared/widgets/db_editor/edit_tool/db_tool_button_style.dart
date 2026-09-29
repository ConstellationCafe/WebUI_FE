import 'package:flutter/material.dart';

import 'package:constellation_cafe/shared/constants/db_editor_tokens.dart';

/// 편집 도구 버튼의 공통 크기·여백.
final ButtonStyle dbToolButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(0, DbEditorTokens.toolButtonMinHeight),
  padding: const EdgeInsets.symmetric(
    horizontal: DbEditorTokens.toolButtonHorizontalPadding,
  ),
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);
