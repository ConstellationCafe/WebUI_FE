import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/ConstPadding.dart';
import '../../../core/constants/ScreenWidth/ScreenWidth.dart';
import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';

class GuildSelectPage extends ConsumerWidget {
  final Widget? child;

  const GuildSelectPage({super.key, this.child});

  bool _isDesktop(String deviceType) => deviceType != "mobileWidth";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceType = ScreenWidth.widthChecker(MediaQuery.sizeOf(context).width);
    final isDesktop = _isDesktop(deviceType);
    final login = ref.watch(loginCheckProvider);

    return login.when(
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
        data: (isLoggedIn) {
          if (!isLoggedIn) return const SizedBox.shrink();
          return Scaffold();
        }
    );
  }
}
