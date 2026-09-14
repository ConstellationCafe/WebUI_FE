import 'package:constellation_cafe/di/ApiProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';
import 'profile_icon.dart';

class ProfileMenu extends ConsumerWidget {
  final VoidCallback? onTap;

  const ProfileMenu({super.key, this.onTap});

  Future<void> performLogout(BuildContext context, WidgetRef ref) async {
    ref.read(loginCheckProvider.notifier).forceLogout();

    try {
      final loginApi = ref.read(loginApiProvider);
      await loginApi.logout();
    } catch (_) {}

    ref.read(currentUserStateProvider.notifier).clear();

    if (!context.mounted) return;
    context.go('/login');
  }

  Future<void> route(BuildContext context, WidgetRef ref, selected) async {
    if (selected == null) return;
    switch(selected) {
      case 'profile':
        context.go('/profile');
        break;
      case 'logout':
        await performLogout(context, ref);
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTapDown: (details) async {
        final renderBox = context.findRenderObject() as RenderBox;
        final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

        final topLeft = renderBox.localToGlobal(
          Offset(0, renderBox.size.height+18),
          ancestor: overlay,
        );
        final bottomRight = renderBox.localToGlobal(
          renderBox.size.bottomRight(Offset.zero) + Offset(0, renderBox.size.height),
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
              child: Text('프로필 수정'),
            ),
            PopupMenuItem(
              value: 'logout',
              child: Text('로그아웃'),
            ),
          ],
        );
        await route(context, ref, selected);
      },
      child: ProfileIcon(),
    );
  }
}