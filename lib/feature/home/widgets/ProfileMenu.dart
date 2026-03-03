import 'package:constellation_cafe/core/di/ApiProvider.dart';
import 'package:constellation_cafe/core/state/Provider/GlobalStateProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/LoginCheckProvider.dart';
import 'ProfileIcon.dart';

class ProfileMenu extends ConsumerWidget {
  final VoidCallback? onTap;

  const ProfileMenu({super.key, this.onTap});

  Future<void> performLogout(BuildContext context, WidgetRef ref) async {
    ref.read(loginCheckProvider.notifier).forceLogout();

    final loginApi = ref.read(loginApiProvider);
    await loginApi.logout();

    ref.read(globalStateProvider.notifier).clear();

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