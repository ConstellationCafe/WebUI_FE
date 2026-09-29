import 'package:flutter/material.dart';

class DBEditorColors {
  DBEditorColors._();

  static const Color border = Color(0xFFAAAAAA);
  static const Color headerBorder = Color(0xFF9E9E9E);
  static const Color editorBackground = Color(0xFFFFFFFF);
  static const Color selectedCell = Color.from(
    alpha: 0.3,
    red: 158 / 255,
    green: 158 / 255,
    blue: 158 / 255,
  );
  static const Color shadow = Color.from(
    alpha: 0.12,
    red: 0,
    green: 13 / 255,
    blue: 39 / 255,
  );
  static const Color cursor = Color(0xFF000000);
}
