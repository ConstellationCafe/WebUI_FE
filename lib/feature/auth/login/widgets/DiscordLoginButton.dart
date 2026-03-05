// lib/features/auth/presentation/widgets/discord_login_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/ConstPadding.dart';
import 'package:constellation_cafe/core/constants/ConstSize.dart';
import 'package:constellation_cafe/core/di/ApiProvider.dart';
import 'package:constellation_cafe/core/constants/ScreenWidth/ScreenWidth.dart';

class DiscordLoginButton extends ConsumerWidget {
  const DiscordLoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginApi = ref.read(loginApiProvider);

    final width = MediaQuery.sizeOf(context).width;
    final deviceType = ScreenWidth.widthChecker(width);
    final isDesktop = deviceType == "wideWidth" || deviceType == "laptopWidth";

    return SizedBox(
      width: isDesktop ? 200 : double.infinity,
      height: 40,
      child: ElevatedButton.icon(
        onPressed: () => loginApi.discordLogin(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: ConstPadding.tinyPadding,
            vertical: 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        icon: const Icon(Icons.discord, size: 18),
        label: const Text(
          "Discord로 로그인",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyle(fontSize: ConstSize.bigTextSize),
        ),
      ),
    );
  }
}
