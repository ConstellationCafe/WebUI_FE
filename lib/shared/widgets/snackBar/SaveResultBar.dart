import 'package:flutter/material.dart';

enum SaveResultType { success, error, warning, info, loading }

class SaveResultBar {
  /// 단일 스낵바 생성 (내부/호환용)
  static SnackBar buildOne(
      BuildContext context,
      String message, {
        SaveResultType type = SaveResultType.info,
        Duration duration = const Duration(seconds: 3),
        String? actionLabel,
        VoidCallback? onAction,
      }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final _Style style = _styleOf(type, scheme);

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      elevation: 8,
      duration: type == SaveResultType.loading ? const Duration(days: 1) : duration,
      backgroundColor: style.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      dismissDirection: DismissDirection.horizontal,
      content: Row(
        children: [
          Icon(style.icon, color: style.fg),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: style.fg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (type == SaveResultType.loading) ...[
            const SizedBox(width: 12),
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                valueColor: AlwaysStoppedAnimation<Color>(style.fg),
              ),
            ),
          ],
        ],
      ),
      action: (actionLabel != null && onAction != null)
          ? SnackBarAction(
        label: actionLabel,
        onPressed: onAction,
        textColor: style.fg,
      )
          : null,
    );
  }

  /// 여러 메시지를 "각 원소마다" 순서대로 띄움
  static Future<void> showAll(
      BuildContext context,
      List<String> messages, {
        SaveResultType type = SaveResultType.info,
        Duration durationPerBar = const Duration(seconds: 3),
        bool clearBefore = false,
        String? actionLabel,
        VoidCallback? onAction,
      }) async {
    final messenger = ScaffoldMessenger.of(context);

    if (clearBefore) {
      messenger.clearSnackBars();
    }

    for (final msg in messages) {
      final message = msg.trim();
      if (message.isEmpty) continue;

      messenger.showSnackBar(
        buildOne(
          context,
          message,
          type: type,
          duration: durationPerBar,
          actionLabel: actionLabel,
          onAction: onAction,
        ),
      );

      // 현재 스낵바가 사라진 뒤 다음 메시지 표시
      await Future.delayed(durationPerBar);

      // 사용자가 스와이프로 미리 닫는 경우 등, 큐가 꼬이는 걸 줄이려면 한 번 더 정리(선택)
      messenger.hideCurrentSnackBar();
    }
  }

  /// (요청하신 시그니처) build가 List<String>를 받게 하고 싶으면
  /// "첫 번째 메시지"용 SnackBar 하나만 만들어 반환하도록 두고,
  /// 실제로 여러 개 띄우는 건 showAll을 쓰는 구조가 안전합니다.
  static SnackBar build(
      BuildContext context,
      String message, {
        SaveResultType type = SaveResultType.info,
        Duration duration = const Duration(seconds: 3),
        String? actionLabel,
        VoidCallback? onAction,
      }) {
    return buildOne(
      context,
      message,
      type: type,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static _Style _styleOf(SaveResultType type, ColorScheme scheme) {
    switch (type) {
      case SaveResultType.success:
        return _Style(
          bg: scheme.onPrimary,
          fg: scheme.primary,
          icon: Icons.check_circle_rounded,
        );

      case SaveResultType.error:
        return _Style(
          bg: scheme.error,
          fg: scheme.onError,
          icon: Icons.error_rounded,
        );

      case SaveResultType.warning:
        return _Style(
          bg: scheme.tertiary,
          fg: scheme.onTertiary,
          icon: Icons.warning_rounded,
        );

      case SaveResultType.loading:
        return _Style(
          bg: scheme.secondary,
          fg: scheme.onSecondary,
          icon: Icons.cloud_upload_rounded,
        );

      case SaveResultType.info:
        return _Style(
          bg: scheme.inversePrimary,
          fg: scheme.onSecondary,
          icon: Icons.info_rounded,
        );
    }
  }
}

class _Style {
  final Color bg;
  final Color fg;
  final IconData icon;
  const _Style({required this.bg, required this.fg, required this.icon});
}
