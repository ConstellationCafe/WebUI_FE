import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/penalty_formats.dart';
import '../constants/penalty_strings.dart';
import '../constants/penalty_tokens.dart';
import '../domain/model/penalty_member.dart';
import 'penalty_identity.dart';
import 'penalty_score_badge.dart';

/// 30일 누적 순위의 회원 한 줄.
class PenaltyRankingTile extends StatelessWidget {
  final PenaltyMember member;
  final bool selected;
  final VoidCallback? onTap;

  const PenaltyRankingTile({
    super.key,
    required this.member,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final lastOccurredAt = DateFormat(
      PenaltyFormats.displayDateTime,
    ).format(member.lastOccurredAt.toLocal());

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: PenaltyTokens.cardPadding,
      ),
      selected: selected,
      selectedTileColor: PenaltyTokens.selectedListBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          PenaltyTokens.rankingListTileRadius,
        ),
      ),
      title: PenaltyIdentity(
        username: member.username,
        discordId: member.discordId,
        child: Text(member.username, style: textTheme.titleMedium),
      ),
      subtitle: PenaltyIdentity(
        username: member.username,
        discordId: member.discordId,
        child: Text(
          PenaltyStrings.rankingSummary(
            member.discordId,
            member.penaltyCount30d,
            lastOccurredAt,
          ),
          style: textTheme.bodySmall?.copyWith(
            color: PenaltyTokens.metadataColor,
            fontSize: PenaltyTokens.metadataTextSize,
          ),
        ),
      ),
      trailing: PenaltyScoreBadge(
        score: member.cumulativeScore30d,
        compact: true,
      ),
      onTap: onTap,
    );
  }
}
