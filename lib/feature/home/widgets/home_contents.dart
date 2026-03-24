import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/Notifier/global_state_notifier.dart';
import '../../../routes/login_check_notifier.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final login = ref.watch(loginCheckProvider);
    return login.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (isLoggedIn) {
        if (!isLoggedIn) return const SizedBox.shrink();

        ref.read(globalStateProvider.notifier).initialize();
        return Text(
          "홈페이지 메인 컨텐츠",
          style: TextStyle(fontSize: 24),
        );
      },
    );
  }
}