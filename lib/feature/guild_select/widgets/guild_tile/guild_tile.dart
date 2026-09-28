import 'package:flutter/material.dart';

import '../../constants/guild_constants.dart';
import '../../domain/guild.dart';
import 'guild_icon.dart';
import 'guild_information.dart';

class GuildTile extends StatefulWidget {
  final Guild guild;
  final VoidCallback? onTap;
  final bool isSelecting;

  const GuildTile({
    super.key,
    required this.guild,
    this.onTap,
    this.isSelecting = false,
  });

  @override
  State<GuildTile> createState() => _GuildTileState();
}

class _GuildTileState extends State<GuildTile> {
  /*
  GuildTile
  ├─ MouseRegion        → hover 감지
  ├─ AnimatedContainer  → hover 애니메이션
  ├─ Material           → 카드 표면/elevation
  ├─ InkWell            → 클릭 처리
  ├─ GuildIcon          → 아이콘
  ├─ GuildInformation   → 길드 정보
  └─ Icon               → 이동 표시
  */
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: widget.onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) {
        if (widget.onTap != null) setState(() => _isHovered = true);
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: GuildConstants.tileAnimationDuration,
        ),
        transform: Matrix4.translationValues(
          0,
          _isHovered && widget.onTap != null
              ? -GuildConstants.tileHoverOffset
              : 0,
          0,
        ),
        child: Material(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(GuildConstants.tileRadius),
          elevation: _isHovered && widget.onTap != null
              ? GuildConstants.tileHoverElevation
              : GuildConstants.tileElevation,
          shadowColor: GuildConstants.tileShadowColor,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(GuildConstants.tileRadius),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: GuildConstants.tileHorizontalPadding,
                vertical: GuildConstants.tileVerticalPadding,
              ),
              child: Row(
                children: [
                  GuildIcon(guild: widget.guild),
                  const SizedBox(width: GuildConstants.iconInformationSpacing),
                  Expanded(child: GuildInformation(guild: widget.guild)),
                  const SizedBox(width: GuildConstants.informationArrowSpacing),
                  if (widget.isSelecting)
                    SizedBox.square(
                      dimension: GuildConstants.tileProgressSize,
                      child: CircularProgressIndicator(
                        strokeWidth: GuildConstants.tileProgressStroke,
                        color: theme.colorScheme.secondary,
                      ),
                    )
                  else
                    Icon(
                      Icons.chevron_right_rounded,
                      size: GuildConstants.arrowIconSize,
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
