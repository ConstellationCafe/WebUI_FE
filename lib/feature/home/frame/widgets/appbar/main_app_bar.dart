
import 'package:constellation_cafe/feature/guild_select/notifier/guild_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/home_constants.dart';

class MainAppBar extends ConsumerWidget {
  final bool showMenuButton;

  const MainAppBar({
    super.key,
    this.showMenuButton = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guild = ref.watch(currentGuildStateProvider);

    return SizedBox(
      width: HomeConstants.mainAppBarWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (showMenuButton)
            Builder(
              builder: (scaffoldContext) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(scaffoldContext).openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: HomeConstants.mainAppBarMenuIconSize,
                  ),
                  tooltip: 'Menu',
                );
              },
            )
          else
            GestureDetector(
              onTap: () {
                context.go(
                  Uri(
                    path: '/home',
                    queryParameters: {
                      'guild_id': guild.guildId,
                    },
                  ).toString(),
                );
              },
              child: ClipOval(
                child: Image.network(
                  guild.guildIcon ?? '',
                  width: HomeConstants.mainAppBarGuildIconSize,
                  height: HomeConstants.mainAppBarGuildIconSize,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          const Spacer(),
          Text(guild.guildName),
        ],
      ),
    );
  }
}