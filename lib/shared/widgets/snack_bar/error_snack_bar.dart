import 'package:flutter/material.dart';

import '../../constants/snack_bar_tokens.dart';

/// 네트워크 오류 등 전역 오류 안내 SnackBar.
class ErrorSnackBar extends SnackBar {
  ErrorSnackBar({super.key, required String message})
    : super(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: SnackBarTokens.errorForeground,
              size: SnackBarTokens.errorIconSize,
            ),
            const SizedBox(width: SnackBarTokens.errorIconGap),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: SnackBarTokens.errorForeground,
                  fontSize: SnackBarTokens.errorTextSize,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: SnackBarTokens.errorBackground,
        duration: SnackBarTokens.errorDuration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SnackBarTokens.errorRadius),
        ),
        margin: const EdgeInsets.all(SnackBarTokens.margin),
      );
}
