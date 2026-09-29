import 'package:flutter/material.dart';

import '../../constants/link_key_tokens.dart';

/// 연동 키 화면의 흰 카드.
class LinkKeyCard extends StatelessWidget {
  final Widget child;

  const LinkKeyCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.primary,
        borderRadius: BorderRadius.circular(LinkKeyTokens.cardRadius),
        border: Border.all(
          color: cs.outlineVariant.withValues(
            alpha: LinkKeyTokens.borderOpacity,
          ),
        ),
      ),
      child: child,
    );
  }
}
