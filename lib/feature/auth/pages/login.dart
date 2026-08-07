import 'package:constellation_cafe/feature/auth/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/discord_login_button.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFf5f7fa),
                Color(0xFFc3cfe2),
              ],
            )
        ),
        child: Center(
          child: LoginWidget(),
        )
      ),
    );
  }
}
