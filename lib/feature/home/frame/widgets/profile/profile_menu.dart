import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';
import 'package:constellation_cafe/feature/home/constants/home_constants.dart';
import 'package:constellation_cafe/feature/home/constants/home_strings.dart';

import 'profile_icon.dart';

class ProfileMenu extends ConsumerWidget {
  final VoidCallback? onTap;

  const ProfileMenu({super.key, this.onTap});

  Future<void> route(
    BuildContext context,
    WidgetRef ref,
    String? selected,
  ) async {
    if (selected == null) return;
    switch (selected) {
      case 'profile':
        context.go('/profile');
        break;
      case 'penalties':
        context.go('/my-penalties');
        break;
      case 'select':
        context.go('/select');
        break;
      case 'logout':
        await ref.read(loginCheckProvider.notifier).logout();
        if (!context.mounted) return;
        context.go('/login');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTapDown: (details) async {
        final renderBox = context.findRenderObject() as RenderBox;
        final overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;

        final topLeft = renderBox.localToGlobal(
          Offset(0, renderBox.size.height + HomeConstants.profileMenuOffset),
          ancestor: overlay,
        );
        final bottomRight = renderBox.localToGlobal(
          renderBox.size.bottomRight(Offset.zero) +
              Offset(0, renderBox.size.height),
          ancestor: overlay,
        );

        final position = RelativeRect.fromRect(
          Rect.fromPoints(topLeft, bottomRight),
          Offset.zero & overlay.size,
        );

        final selected = await showMenu<String>(
          context: context,
          position: position,
          items: const [
            PopupMenuItem(
              value: 'profile',
              child: Text(HomeStrings.editProfile),
            ),
            PopupMenuItem(
              value: 'penalties',
              child: Text(HomeStrings.penalties),
            ),
            PopupMenuItem(
              value: 'select',
              child: Text(HomeStrings.selectGuild),
            ),
            PopupMenuItem(value: 'logout', child: Text(HomeStrings.logout)),
          ],
        );
        if (!context.mounted) return;
        await route(context, ref, selected);
      },
      child: const ProfileIcon(),
    );
  }
}
