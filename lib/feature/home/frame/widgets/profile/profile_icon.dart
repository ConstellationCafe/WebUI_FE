import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/home/constants/home_constants.dart';

class ProfileIcon extends ConsumerWidget {
  final VoidCallback? onTap;

  const ProfileIcon({super.key, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarUrl = ref.watch(
      currentUserStateProvider.select((s) => s.avatarUrl),
    );

    return Container(
      width: HomeConstants.profileIconSize,
      height: HomeConstants.profileIconSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: HomeConstants.profileIconBackground,
      ),
      child: ClipOval(
        child: Image.network(
          avatarUrl,
          width: HomeConstants.profileIconSize,
          height: HomeConstants.profileIconSize,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const Icon(
            Icons.person,
            size: HomeConstants.profileFallbackIconSize,
          ),
        ),
      ),
    );
  }
}
