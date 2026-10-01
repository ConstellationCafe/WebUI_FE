import 'package:flutter/material.dart';

import '../constants/point_strings.dart';
import '../constants/point_tokens.dart';

class PointLoadError extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const PointLoadError({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(PointTokens.panelPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text(PointStrings.retry),
            ),
          ],
        ),
      ),
    );
  }
}
