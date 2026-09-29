import 'package:flutter/material.dart';

import 'package:constellation_cafe/shared/widgets/usage/usage_step.dart';

import '../../constants/shadowverse_strings.dart';

class FriendlyMatchUsage {
  static List<UsageStep> steps({
    required GlobalKey submitKey,
    required GlobalKey inputDataKey,
  }) {
    return [
      UsageStep(key: inputDataKey, message: ShadowverseStrings.usageInput),
      UsageStep(key: submitKey, message: ShadowverseStrings.usageSubmit),
    ];
  }

  static const String key = 'friendly_match_tutorial_v0.0.1';
}
