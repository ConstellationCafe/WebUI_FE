import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/auth/widgets/login_widget.dart';
import '../../../core/constants/const_color.dart';


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
                ConstColor.gradientStart,
                ConstColor.gradientEnd,
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
