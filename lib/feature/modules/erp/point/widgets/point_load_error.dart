import 'package:flutter/material.dart';

import '../constants/point_strings.dart';

class PointLoadError extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const PointLoadError({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            TextButton(
              onPressed: onRetry,
              child: const Text(PointStrings.retry),
            ),
          ],
        ),
      ),
    );
  }
}
