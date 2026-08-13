import 'package:flutter/material.dart';

import '../constants/guild_constants.dart';
import '../domain/guild.dart';
import 'empty_guild_list.dart';
import 'guild_tile/guild_tile.dart';

class GuildList extends StatelessWidget {
  final List<Guild> guilds;
  final ValueChanged<Guild>? onGuildSelected;

  const GuildList({
    super.key,
    required this.guilds,
    this.onGuildSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (guilds.isEmpty) {
      return const EmptyGuildList();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: guilds.length,
      separatorBuilder: (_, __) => const SizedBox(
        height: GuildConstants.guildListItemSpacing,
      ),
      itemBuilder: (context, index) {
        final guild = guilds[index];

        return GuildTile(
          guild: guild,
          onTap: () => onGuildSelected?.call(guild),
        );
      },
    );
  }
}