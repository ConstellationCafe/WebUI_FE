import 'package:flutter/material.dart';

import '../../../../core/widgets/usage/usage.dart';

class ProfileUsage {
  static List<UsageStep> steps({
    required GlobalKey membershipCardKey,
    required GlobalKey inputDataKey,
  }) {
    return [
      UsageStep(
        key: membershipCardKey,
        message: '여기서 내 멤버십 정보를 확인할 수 있어요.',
      ),
      UsageStep(
        key: inputDataKey,
        message: '여기에서 멤버십 정보를 수정할 수 있어요.',
      ),
    ];
  }

  static const String key = 'profile_tutorial_v0.0.1';
}