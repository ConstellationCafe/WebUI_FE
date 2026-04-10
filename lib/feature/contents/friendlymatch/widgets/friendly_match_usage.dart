import 'package:flutter/material.dart';

import '../../../../core/widgets/usage/usage.dart';

class FriendlyMatchUsage {
  static List<UsageStep> steps({
    required GlobalKey submitKey,
    required GlobalKey inputDataKey,
  }) {
    return [
      UsageStep(
        key: inputDataKey,
        message: '여기에 친선전 방 정보를 입력하고,',
      ),
      UsageStep(
        key: submitKey,
        message: '전송 버튼을 누르면 빗자루가 있는 모든 채팅방에 전송할 수 있어요',
      ),
    ];
  }

  static const String key = 'friendly_match_tutorial_v0.0.1';
}