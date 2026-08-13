import 'package:flutter/material.dart';

import '../../constants/guild_constants.dart';

/// 길드 아이콘을 표시할 수 없을 때 사용하는 기본 아이콘 위젯.
///
/// - 길드에 아이콘이 없는 경우
/// - 길드 아이콘 이미지 로딩에 실패한 경우
/// 기본 Discord 아이콘을 대신 표시한다.
class FallbackGuildIcon extends StatelessWidget {
  const FallbackGuildIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: GuildConstants.guildIconSize,
      height: GuildConstants.guildIconSize,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.discord,
        color: theme.colorScheme.primary,
        size: GuildConstants.fallbackIconSize,
      ),
    );
  }
}