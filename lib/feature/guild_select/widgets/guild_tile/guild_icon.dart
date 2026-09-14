import 'package:flutter/material.dart';

import '../../constants/guild_constants.dart';
import '../../domain/guild.dart';
import 'fallback_guild_icon.dart';

class GuildIcon extends StatelessWidget {
  final Guild guild;

  const GuildIcon({
    super.key,
    required this.guild,
  });

  @override
  Widget build(BuildContext context) {
    if (guild.iconUrl != null && guild.iconUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(
          GuildConstants.guildIconRadius,
        ),
        child: Image.network(
          guild.iconUrl!,
          width: GuildConstants.guildIconSize,
          height: GuildConstants.guildIconSize,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return const FallbackGuildIcon();
          },
        ),
      );
    }

    return const FallbackGuildIcon();
  }
}