import 'package:flutter/material.dart';

import '../../constants/guild_constants.dart';
import '../../domain/guild.dart';

class GuildInformation extends StatelessWidget {
  final Guild guild;

  const GuildInformation({
    super.key,
    required this.guild,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          guild.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(
          height: GuildConstants.informationSpacing,
        ),
        Row(
          children: [
            Icon(
              Icons.people_outline_rounded,
              size: GuildConstants.memberIconSize,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(
              width: GuildConstants.memberTextSpacing,
            ),
            Text(
              '${guild.memberCount}명',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}