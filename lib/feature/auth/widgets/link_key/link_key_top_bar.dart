import 'package:flutter/material.dart';

import '../../constants/link_key_strings.dart';
import '../../constants/link_key_tokens.dart';

/// 연동 키 화면 상단: 제목, 연동 상태, 카카오 로그인 버튼(준비 중).
class LinkKeyTopBar extends StatelessWidget {
  const LinkKeyTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: LinkKeyTokens.topBarHorizontalPadding,
        vertical: LinkKeyTokens.topBarVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: cs.primary,
        borderRadius: BorderRadius.circular(LinkKeyTokens.panelRadius),
        border: Border.all(
          color: cs.outlineVariant.withValues(
            alpha: LinkKeyTokens.borderOpacity,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: LinkKeyTokens.topBarLogoSize,
            height: LinkKeyTokens.topBarLogoSize,
            decoration: BoxDecoration(
              color: cs.secondary,
              borderRadius: BorderRadius.circular(
                LinkKeyTokens.topBarLogoRadius,
              ),
            ),
          ),
          const SizedBox(width: LinkKeyTokens.gap),
          Text(
            LinkKeyStrings.topBarTitle,
            style: TextStyle(
              color: cs.secondary,
              fontSize: LinkKeyTokens.topBarTitleSize,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          Text(
            LinkKeyStrings.linkStatusLoginRequired,
            style: TextStyle(
              color: cs.onSurface.withValues(
                alpha: LinkKeyTokens.mutedTextOpacity,
              ),
            ),
          ),
          const SizedBox(width: LinkKeyTokens.gap),
          ElevatedButton(
            onPressed: () {
              // TODO: 카카오 OAuth 로그인
            },
            child: const Text(LinkKeyStrings.kakaoLogin),
          ),
        ],
      ),
    );
  }
}
