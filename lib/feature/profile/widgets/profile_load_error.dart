import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';

import '../constants/profile_strings.dart';

/// 회원증을 불러오지 못했을 때의 안내와 다시 시도 버튼.
class ProfileLoadError extends StatelessWidget {
  final VoidCallback onRetry;

  const ProfileLoadError({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(ProfileStrings.loadFailed),
          const SizedBox(height: ConstSize.smallSpacing),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text(ProfileStrings.retry),
          ),
        ],
      ),
    );
  }
}
