import 'package:flutter/material.dart';

import '../constants/penalty_strings.dart';

/// 벌점 데이터 조회 실패 안내와 다시 시도 버튼.
class PenaltyLoadError extends StatelessWidget {
  final VoidCallback onRetry;

  const PenaltyLoadError({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(PenaltyStrings.loadFailed),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text(PenaltyStrings.retry),
        ),
      ],
    ),
  );
}
