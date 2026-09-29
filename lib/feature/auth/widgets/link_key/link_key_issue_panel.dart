import 'package:flutter/material.dart';

import '../../constants/link_key_strings.dart';
import '../../constants/link_key_tokens.dart';
import 'link_key_card.dart';
import 'link_key_code_box.dart';
import 'link_key_steps.dart';
import 'link_key_top_bar.dart';

/// 연동 키 발급·복사 영역.
class LinkKeyIssuePanel extends StatelessWidget {
  /// 아직 만료되지 않은 키. 없으면 null.
  final String? activeCode;
  final String remainingText;
  final VoidCallback onIssue;
  final VoidCallback onCopy;

  const LinkKeyIssuePanel({
    super.key,
    required this.activeCode,
    required this.remainingText,
    required this.onIssue,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasActiveCode = activeCode != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const LinkKeyTopBar(),
        const SizedBox(height: LinkKeyTokens.stackedGap),
        LinkKeyCard(
          child: Padding(
            padding: const EdgeInsets.all(LinkKeyTokens.sectionPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LinkKeyStrings.title,
                  style: TextStyle(
                    color: cs.secondary,
                    fontSize: LinkKeyTokens.titleSize,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: LinkKeyTokens.titleGap),
                Text(
                  LinkKeyStrings.description,
                  style: TextStyle(color: cs.onSurface),
                ),
                const SizedBox(height: LinkKeyTokens.stepsTopGap),
                const LinkKeySteps(),
                const SizedBox(height: LinkKeyTokens.keyLabelTopGap),
                Text(
                  LinkKeyStrings.keyLabel,
                  style: TextStyle(
                    color: cs.secondary,
                    fontSize: LinkKeyTokens.keyLabelSize,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: LinkKeyTokens.keyLabelGap),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: LinkKeyTokens.gap,
                  runSpacing: LinkKeyTokens.gap,
                  children: [
                    LinkKeyCodeBox(code: activeCode),
                    SizedBox(
                      height: LinkKeyTokens.buttonHeight,
                      child: ElevatedButton(
                        onPressed: hasActiveCode ? onCopy : null,
                        child: const Text(LinkKeyStrings.copy),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: LinkKeyTokens.buttonsTopGap),
                Wrap(
                  spacing: LinkKeyTokens.gap,
                  runSpacing: LinkKeyTokens.gap,
                  children: [
                    SizedBox(
                      height: LinkKeyTokens.buttonHeight,
                      child: ElevatedButton(
                        onPressed: onIssue,
                        child: Text(
                          hasActiveCode
                              ? LinkKeyStrings.reissueOverwrite
                              : LinkKeyStrings.issue,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: LinkKeyTokens.buttonHeight,
                      child: ElevatedButton(
                        onPressed: null, // TODO: 쿨다운 정책이 있으면 여기서 활성화 제어
                        child: Text(
                          hasActiveCode
                              ? LinkKeyStrings.reissueAfter(remainingText)
                              : LinkKeyStrings.reissue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: LinkKeyTokens.gap),
                Text(
                  LinkKeyStrings.securityNotice,
                  style: TextStyle(
                    color: cs.onSurface.withValues(
                      alpha: LinkKeyTokens.noticeOpacity,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
