import 'package:flutter/material.dart';

import '../../constants/link_key_strings.dart';
import '../../constants/link_key_tokens.dart';

/// 발급한 연동 키 표시. 유효한 키가 없으면 자리 표시를 보여준다.
class LinkKeyCodeBox extends StatelessWidget {
  final String? code;

  const LinkKeyCodeBox({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: LinkKeyTokens.codeBoxWidth,
      height: LinkKeyTokens.codeBoxHeight,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(
        horizontal: LinkKeyTokens.codeBoxHorizontalPadding,
      ),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(LinkKeyTokens.panelRadius),
        border: Border.all(
          color: cs.outline,
          width: LinkKeyTokens.codeBoxBorderWidth,
        ),
      ),
      child: Text(
        code ?? LinkKeyStrings.emptyCode,
        style: TextStyle(
          color: cs.secondary,
          fontSize: LinkKeyTokens.codeTextSize,
          fontWeight: FontWeight.w900,
          letterSpacing: LinkKeyTokens.codeLetterSpacing,
        ),
      ),
    );
  }
}
