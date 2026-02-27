import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Routes/RouteProvider.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'core/constants/Theme/ThemeData.dart';
import 'core/state/Provider/GlobalStateProvider.dart';

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
    // 전역 상태
    ref.watch(globalStateProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: CustomTheme.themeData,
    );
  }
}
