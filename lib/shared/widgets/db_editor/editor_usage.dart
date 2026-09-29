import 'package:flutter/material.dart';

import '../../constants/db_editor_strings.dart';
import '../usage/usage_step.dart';

class EditorUsage {
  static List<UsageStep> steps({
    required GlobalKey columnKey,
    required GlobalKey viewKey,
    required GlobalKey addKey,
    required GlobalKey deleteKey,
    required GlobalKey editKey,
    required GlobalKey saveKey,
  }) {
    return [
      UsageStep(key: columnKey, message: DbEditorStrings.usageColumn),
      UsageStep(key: viewKey, message: DbEditorStrings.usageView),
      UsageStep(key: addKey, message: DbEditorStrings.usageAdd),
      UsageStep(key: deleteKey, message: DbEditorStrings.usageDelete),
      UsageStep(key: editKey, message: DbEditorStrings.usageEdit),
      UsageStep(key: saveKey, message: DbEditorStrings.usageSave),
    ];
  }

  static const String key = 'editor_tutorial_v0.0.1';
}
