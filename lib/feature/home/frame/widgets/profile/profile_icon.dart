
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';

class ProfileIcon extends ConsumerWidget {
  final VoidCallback? onTap;

  const ProfileIcon({super.key, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarUrl = ref.watch(
      currentUserStateProvider.select((s) => s.avatarUrl),
    );

    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: ClipOval(
        child: Image.network(
          avatarUrl,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.person,
            size: 30,
          ),
        ),
      ),
    );
  }
}