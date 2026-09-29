import 'package:flutter/material.dart';

import '../../constants/link_key_strings.dart';
import '../../constants/link_key_tokens.dart';
import 'link_key_card.dart';

/// 남은 시간, QR 자리, 카카오톡 입력 안내.
class LinkKeyTimerPanel extends StatelessWidget {
  final bool hasCode;
  final double progress;
  final String remainingText;

  const LinkKeyTimerPanel({
    super.key,
    required this.hasCode,
    required this.progress,
    required this.remainingText,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final border = Border.all(
      color: cs.outlineVariant.withValues(alpha: LinkKeyTokens.borderOpacity),
    );
    final sectionTitleStyle = TextStyle(
      color: cs.secondary,
      fontWeight: FontWeight.w800,
    );

    return LinkKeyCard(
      child: Padding(
        padding: const EdgeInsets.all(LinkKeyTokens.timerPanelPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              LinkKeyStrings.untilExpiry,
              style: TextStyle(
                color: cs.secondary,
                fontSize: LinkKeyTokens.timerTitleSize,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: LinkKeyTokens.gap),
            Center(
              child: SizedBox(
                width: LinkKeyTokens.timerSize,
                height: LinkKeyTokens.timerSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: hasCode ? progress : 0,
                      strokeWidth: LinkKeyTokens.timerStrokeWidth,
                      backgroundColor: cs.outlineVariant.withValues(
                        alpha: LinkKeyTokens.borderOpacity,
                      ),
                      valueColor: AlwaysStoppedAnimation(cs.secondary),
                    ),
                    Text(
                      hasCode ? remainingText : LinkKeyStrings.emptyTimer,
                      style: TextStyle(
                        color: cs.secondary,
                        fontSize: LinkKeyTokens.timerTextSize,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: LinkKeyTokens.sectionGap),
            Text(LinkKeyStrings.qrTitle, style: sectionTitleStyle),
            const SizedBox(height: LinkKeyTokens.keyLabelGap),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(
                    LinkKeyTokens.panelRadius,
                  ),
                  border: border,
                ),
                child: Center(
                  child: Text(
                    LinkKeyStrings.qrPlaceholder,
                    style: TextStyle(
                      color: cs.onSurface.withValues(
                        alpha: LinkKeyTokens.qrPlaceholderOpacity,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: LinkKeyTokens.sectionGap),
            Text(LinkKeyStrings.kakaoInputTitle, style: sectionTitleStyle),
            const SizedBox(height: LinkKeyTokens.keyLabelGap),
            Container(
              padding: const EdgeInsets.all(LinkKeyTokens.guidePadding),
              decoration: BoxDecoration(
                color: cs.surface.withValues(
                  alpha: LinkKeyTokens.guideBackgroundOpacity,
                ),
                borderRadius: BorderRadius.circular(LinkKeyTokens.panelRadius),
                border: border,
              ),
              child: const Text(LinkKeyStrings.kakaoInputGuide),
            ),
          ],
        ),
      ),
    );
  }
}
