import 'package:flutter/material.dart';

import '../../../../core/widgets/usage/usage_step.dart';

class ProfileUsage {
  static List<UsageStep> steps({
    required GlobalKey pointLogButtonKey,
    required GlobalKey inputDataKey,
  }) {
    return [
      UsageStep(
        key: inputDataKey,
        message: '여기에서 변경할 값을 입력하고 저장 버튼을 누르면 수정 할 수 있어요',
      ),
      UsageStep(
        key: pointLogButtonKey,
        message: '또한 해당 버튼을 누르면 포인트 입출 내역를 확인 할 수 있어요',
      ),
    ];
  }

  static const String key = 'profile_tutorial_v0.0.1';
}