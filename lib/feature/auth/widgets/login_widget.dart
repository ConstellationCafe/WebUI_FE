import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';

import '../constants/auth_constants.dart';
import '../constants/auth_strings.dart';
import 'discord_login_button.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final compact = screenWidth < ScreenWidth.mobileWidth;
    final logoSize = compact
        ? AuthConstants.loginLogoMobileSize
        : AuthConstants.loginLogoSize;

    // 모바일에서는 카드가 화면 너비를 쓰고 로고·제목·버튼을 키운다.
    return Container(
      margin: compact
          ? const EdgeInsets.all(AuthConstants.loginCardMobileMargin)
          : EdgeInsets.zero,
      constraints: compact
          ? null
          : const BoxConstraints(maxWidth: AuthConstants.loginCardMaxWidth),
      padding: compact
          ? const EdgeInsets.symmetric(
              horizontal: AuthConstants.loginCardMobileHorizontalPadding,
              vertical: AuthConstants.loginCardMobileVerticalPadding,
            )
          : const EdgeInsets.symmetric(
              horizontal: AuthConstants.loginCardHorizontalPadding,
              vertical: AuthConstants.loginCardVerticalPadding,
            ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(AuthConstants.loginCardRadius),
        boxShadow: const [
          BoxShadow(
            color: AuthConstants.loginShadowColor,
            blurRadius: AuthConstants.loginShadowBlurRadius,
            offset: Offset(0, AuthConstants.loginShadowOffsetY),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  AuthConstants.loginLogoRadius,
                ),
                child: Image.asset(
                  AuthConstants.logoAsset,
                  width: logoSize,
                  height: logoSize,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const SizedBox(width: ConstPadding.smallPadding),
              Expanded(
                child: Text(
                  AuthStrings.serviceName,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: compact
                        ? AuthConstants.loginTitleMobileFontSize
                        : AuthConstants.loginTitleFontSize,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: compact
                ? AuthConstants.loginButtonMobileGap
                : ConstPadding.mediumPadding,
          ),
          const DiscordLoginButton(),
        ],
      ),
    );
  }
}
