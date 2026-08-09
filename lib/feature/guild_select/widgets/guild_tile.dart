import 'package:flutter/material.dart';

import '../domain/guild.dart';

class GuildTile extends StatefulWidget {
  final Guild guild;
  final VoidCallback? onTap;

  const GuildTile({
    super.key,
    required this.guild,
    this.onTap,
  });

  @override
  State<GuildTile> createState() => _GuildTileState();
}

class _GuildTileState extends State<GuildTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.translationValues(
          0,
          _isHovered ? -2 : 0,
          0,
        ),
        child: Material(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
          elevation: _isHovered ? 6 : 3,
          shadowColor: Colors.black.withValues(alpha: 0.12),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              child: Row(
                children: [
                  _GuildIcon(guild: widget.guild),

                  const SizedBox(width: 20),

                  Expanded(
                    child: _GuildInformation(guild: widget.guild),
                  ),

                  const SizedBox(width: 16),

                  Icon(
                    Icons.chevron_right_rounded,
                    size: 30,
                    color: theme.colorScheme.secondary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GuildIcon extends StatelessWidget {
  final Guild guild;

  const _GuildIcon({
    required this.guild,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    if (guild.iconUrl != null && guild.iconUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.network(
          guild.iconUrl!,
          width: 64,
          height: 64,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return _FallbackGuildIcon();
          },
        ),
      );
    }

    return _FallbackGuildIcon();
  }
}

class _FallbackGuildIcon extends StatelessWidget {
  const _FallbackGuildIcon();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.discord,
        color: Colors.white,
        size: 34,
      ),
    );
  }
}

class _GuildInformation extends StatelessWidget {
  final Guild guild;

  const _GuildInformation({
    required this.guild,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                guild.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge,
              ),
            ),

            // if (guild.hasErpRole) ...[
            //   const SizedBox(width: 10),
            //   Container(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 9,
            //       vertical: 4,
            //     ),
            //     decoration: BoxDecoration(
            //       color: theme.colorScheme.secondary,
            //       borderRadius: BorderRadius.circular(6),
            //     ),
            //     child: Text(
            //       'ERP',
            //       style: theme.textTheme.labelSmall?.copyWith(
            //         color: theme.colorScheme.primary,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ],
          ],
        ),

        // if (guild.description != null) ...[
        //   const SizedBox(height: 5),
        //   Text(
        //     guild.description!,
        //     maxLines: 1,
        //     overflow: TextOverflow.ellipsis,
        //     style: theme.textTheme.bodyMedium?.copyWith(
        //       color: theme.colorScheme.onSurfaceVariant,
        //     ),
        //   ),
        // ],

        const SizedBox(height: 8),

        Row(
          children: [
            Icon(
              Icons.people_outline_rounded,
              size: 17,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 5),
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