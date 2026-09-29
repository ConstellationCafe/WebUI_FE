import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../constants/academy_constants.dart';
import '../constants/academy_strings.dart';

/// 아카데미 화면의 조회·처리 실패 안내. 내부 오류 문구 대신 고정 안내를 보여준다.
class AcademyErrorBanner extends StatelessWidget {
  final VoidCallback? onRetry;

  const AcademyErrorBanner({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final retry = onRetry;
    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        padding: ConstPadding.mediumPaddingAll,
        decoration: BoxDecoration(
          color: colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(
            AcademyConstants.cardBorderRadius,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: colorScheme.onErrorContainer),
            const SizedBox(width: ConstPadding.smallPadding),
            Expanded(
              child: Text(
                AcademyStrings.loadFailed,
                style: TextStyle(color: colorScheme.onErrorContainer),
              ),
            ),
            if (retry != null)
              TextButton(
                onPressed: retry,
                child: const Text(AcademyStrings.retry),
              ),
          ],
        ),
      ),
    );
  }
}
