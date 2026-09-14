import 'package:flutter/material.dart';

import '../../../core/constants/const_padding.dart';
import '../../../core/constants/screen_width.dart';
import '../constants/auth_constants.dart';
import 'discord_login_button.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final outerMargin = screenWidth < ScreenWidth.mobileWidth
        ? ConstPadding.mediumPaddingAll
        : EdgeInsets.zero;

    return Container(
      margin: outerMargin,
      constraints: const BoxConstraints(
        maxWidth: AuthConstants.loginCardMaxWidth,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AuthConstants.loginCardHorizontalPadding,
        vertical: AuthConstants.loginCardVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(
          AuthConstants.loginCardRadius,
        ),
        boxShadow: const [
          BoxShadow(
            color: AuthConstants.loginShadowColor,
            blurRadius: AuthConstants.loginShadowBlurRadius,
            offset: Offset(
              0,
              AuthConstants.loginShadowOffsetY,
            ),
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
                  'assets/icons/main_icon.jpg',
                  width: AuthConstants.loginLogoSize,
                  height: AuthConstants.loginLogoSize,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const SizedBox(
                width: ConstPadding.smallPadding,
              ),
              Expanded(
                child: Text(
                  'ERP Web Service',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                    fontSize: AuthConstants.loginTitleFontSize,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: ConstPadding.mediumPadding,
          ),
          const DiscordLoginButton(),
        ],
      ),
    );
  }
}