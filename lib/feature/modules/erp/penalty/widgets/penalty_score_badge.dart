import 'package:flutter/material.dart';

import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';

class PenaltyScoreBadge extends StatelessWidget {
  final int score;
  final String label;
  final bool compact;

  const PenaltyScoreBadge({
    super.key,
    required this.score,
    this.label = PenaltyStrings.cumulativeScore,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
      color: PenaltyTokens.scoreBadgeForeground,
      fontSize: PenaltyTokens.metadataTextSize,
      fontWeight: FontWeight.w700,
    );
    final scoreStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: PenaltyTokens.scoreBadgeForeground,
      fontSize: compact
          ? PenaltyTokens.compactScoreTextSize
          : PenaltyTokens.cumulativeScoreTextSize,
      fontWeight: FontWeight.w800,
    );
    final horizontalPadding = compact
        ? PenaltyTokens.compactScoreBadgeHorizontalPadding
        : PenaltyTokens.scoreBadgeHorizontalPadding;
    final verticalPadding = compact
        ? PenaltyTokens.compactScoreBadgeVerticalPadding
        : PenaltyTokens.scoreBadgeVerticalPadding;

    return Semantics(
      label: PenaltyStrings.scoreSemantics(label, score),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: PenaltyTokens.scoreBadgeBackground,
          borderRadius: BorderRadius.circular(PenaltyTokens.scoreBadgeRadius),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(label, style: labelStyle),
              Text(PenaltyStrings.scoreValue(score), style: scoreStyle),
            ],
          ),
        ),
      ),
    );
  }
}
