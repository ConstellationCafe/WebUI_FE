import 'package:flutter/material.dart';

import '../constants/profile_constants.dart';

class SaveMembershipButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const SaveMembershipButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              width: ProfileConstants.loadingIndicatorSize,
              height: ProfileConstants.loadingIndicatorSize,
              child: CircularProgressIndicator(
                strokeWidth:
                ProfileConstants.loadingIndicatorStrokeWidth,
                color: theme.colorScheme.onPrimary,
              ),
            )
          : Text(
              '저장',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
            ),
    );
  }
}