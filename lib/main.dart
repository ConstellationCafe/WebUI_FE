import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'router/router_provider.dart';
import 'core/constants/theme_data.dart';
import 'core/keys/AppKeys.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'DiscordBot ERP Web',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: CustomTheme.themeData,
      scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,
    );
  }
}
