import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/di/ApiProvider.dart';
import '../constants/auth_constants.dart';

class DiscordLoginButton extends ConsumerWidget {
  const DiscordLoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginApi = ref.read(loginApiProvider);
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = ScreenWidth.isDesktop(width);
    return SizedBox(
      width: isDesktop
          ? AuthConstants.discordLoginButtonDesktopWidth
          : double.infinity,
      height: AuthConstants.discordLoginButtonHeight,
      child: ElevatedButton.icon(
        onPressed: loginApi.discordLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: AuthConstants.discordLoginButtonColor,
          foregroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: ConstPadding.tinyPadding,
            vertical: 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AuthConstants.discordLoginButtonRadius,
            ),
          ),
        ),
        icon: const Icon(
          Icons.discord,
          size: AuthConstants.discordLoginButtonIconSize,
        ),
        label: Text(
          'Discord로 로그인',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: ConstSize.mediumTextSize,
            color: AuthConstants.discordLoginButtonTextColor,
          ),
        ),
      ),
    );
  }
}