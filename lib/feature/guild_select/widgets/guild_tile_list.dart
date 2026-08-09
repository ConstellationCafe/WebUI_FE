import 'package:flutter/material.dart';

import '../domain/guild.dart';
import 'guild_tile.dart';

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
      return const _EmptyGuildList();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: guilds.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
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

class _EmptyGuildList extends StatelessWidget {
  const _EmptyGuildList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.forum_outlined,
            size: 48,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            '사용할 수 있는 채팅방이 없습니다.',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'ERP 서비스를 이용할 수 있는 채팅방이 없습니다.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}