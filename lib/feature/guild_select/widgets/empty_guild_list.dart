import 'package:flutter/material.dart';

import '../constants/guild_constants.dart';
import '../constants/guild_select_strings.dart';

/// 사용할 수 있는 길드가 없을 때 표시하는 빈 상태 UI.
class EmptyGuildList extends StatelessWidget {
  const EmptyGuildList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(GuildConstants.emptyListPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(GuildConstants.emptyListRadius),
      ),
      child: Column(
        children: [
          Icon(
            Icons.forum_outlined,
            size: GuildConstants.emptyListIconSize,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: GuildConstants.emptyListTitleSpacing),
          Text(
            GuildSelectStrings.emptyTitle,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: GuildConstants.emptyListDescriptionSpacing),
          Text(
            GuildSelectStrings.emptyDescription,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
