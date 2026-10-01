import 'package:flutter/material.dart';

import '../constants/guild_constants.dart';
import '../constants/guild_select_strings.dart';

class SelectPageFooter extends StatelessWidget {
  const SelectPageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock_outline_rounded,
          size: GuildConstants.footerIconSize,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: GuildConstants.footerIconSpacing),
        Text(
          GuildSelectStrings.footer,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
