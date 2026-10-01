import 'package:flutter/material.dart';

import '../../constants/link_key_tokens.dart';

/// 연동 절차의 한 단계.
class LinkKeyStepCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const LinkKeyStepCard({
    super.key,
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(LinkKeyTokens.stepPadding),
      decoration: BoxDecoration(
        color: cs.surface.withValues(
          alpha: LinkKeyTokens.stepBackgroundOpacity,
        ),
        borderRadius: BorderRadius.circular(LinkKeyTokens.panelRadius),
        border: Border.all(
          color: cs.outlineVariant.withValues(
            alpha: LinkKeyTokens.borderOpacity,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: LinkKeyTokens.stepNumberSize,
                height: LinkKeyTokens.stepNumberSize,
                decoration: BoxDecoration(
                  color: cs.secondary,
                  borderRadius: BorderRadius.circular(
                    LinkKeyTokens.stepNumberRadius,
                  ),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: TextStyle(
                      color: cs.onSecondary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: LinkKeyTokens.stepInnerGap),
              Text(
                title,
                style: TextStyle(
                  color: cs.secondary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: LinkKeyTokens.stepInnerGap),
          Text(description, style: TextStyle(color: cs.onSurface)),
        ],
      ),
    );
  }
}
