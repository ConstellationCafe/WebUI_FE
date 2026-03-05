// lib/features/auth/presentation/pages/login.dart
import 'package:flutter/material.dart';

import '../../../../core/constants/ConstSize.dart';
import '../widgets/DiscordLoginButton.dart';
import '../../../../core/constants/ConstPadding.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.sizeOf(context).width;

    const cardHPadding = 36.0;
    const cardVPadding = 28.0;

    final outerMargin = screenW < 500 ? 16.0 : 0.0;
    final maxCardWidth = 400.0;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: outerMargin),
          child: ConstrainedBox(
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
                crossAxisAlignment: CrossAxisAlignment.stretch, // ★ 가로로 꽉 채우기
                children: [
                  // Row가 Column 폭(=DiscordLoginButton 폭)과 동일하게 되도록
                  SizedBox(
                    width: double.infinity, // ★ Row 영역을 최대폭으로 고정
                    child: Row(
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
                  ),
                  const SizedBox(height: 16),

                  // 버튼도 같은 폭(=Column 폭)으로
                  const SizedBox(
                    width: double.infinity, // ★ 버튼 폭도 최대폭으로 고정
                    child: DiscordLoginButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
