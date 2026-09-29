import 'package:flutter/material.dart';

import '../constants/guild_constants.dart';
import '../constants/guild_select_strings.dart';

class SelectPageHeader extends StatelessWidget {
  const SelectPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: GuildConstants.headerIconBoxSize,
          height: GuildConstants.headerIconBoxSize,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(
              GuildConstants.headerIconBoxRadius,
            ),
            boxShadow: const [
              BoxShadow(
                color: GuildConstants.headerShadowColor,
                blurRadius: GuildConstants.headerShadowBlur,
                offset: GuildConstants.headerShadowOffset,
              ),
            ],
          ),
          child: Icon(
            Icons.bar_chart_rounded,
            size: GuildConstants.headerIconSize,
            color: theme.colorScheme.secondary,
          ),
        ),

        const SizedBox(height: GuildConstants.headerTitleSpacing),

        Text(
          GuildSelectStrings.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium,
        ),

        const SizedBox(height: GuildConstants.headerDescriptionSpacing),

        Text(
          GuildSelectStrings.description,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
