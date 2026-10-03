import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'core/constants/theme_data.dart';
import 'core/keys/app_keys.dart';
import 'feature/guild_select/notifier/selected_guild_persistence.dart';
import 'router/router_provider.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    // 새로고침 뒤에도 헤더의 채팅방 로고·이름을 유지하도록 선택한 채팅방을 저장·복원한다.
    ref.watch(selectedGuildPersistenceProvider);
    return MaterialApp.router(
      title: 'DiscordBot ERP Web',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: CustomTheme.themeData,
      scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,
    );
  }
}
