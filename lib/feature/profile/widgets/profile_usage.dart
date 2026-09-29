import 'package:flutter/material.dart';

import 'package:constellation_cafe/shared/widgets/usage/usage_step.dart';

import '../constants/profile_strings.dart';

class ProfileUsage {
  static List<UsageStep> steps({
    required GlobalKey pointLogButtonKey,
    required GlobalKey inputDataKey,
  }) {
    return [
      UsageStep(key: inputDataKey, message: ProfileStrings.usageInput),
      UsageStep(key: pointLogButtonKey, message: ProfileStrings.usagePointLog),
    ];
  }

  static const String key = 'profile_tutorial_v0.0.1';
}
