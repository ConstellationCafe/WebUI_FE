import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'discord_login_button.dart';

class LoginWidget extends ConsumerWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenW = MediaQuery.sizeOf(context).width;

    const cardHPadding = 36.0;
    const cardVPadding = 28.0;

    final outerMargin = screenW < 500 ? 16.0 : 0.0;
    final maxCardWidth = 360.0;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxCardWidth),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: cardHPadding,
          vertical: cardVPadding,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 상단 사이트 정보 부분
            // Row가 Column 폭과 동일하게 되도록 SizedBox 사용
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/icons/main_icon.jpg',
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "섀버 별자리 Cafe",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 디스코드 로그인
            const SizedBox(
              width: double.infinity,
              child: DiscordLoginButton(),
            ),
          ],
        ),
      )
    );
  }
}