import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/const_color.dart';
import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/di/ApiProvider.dart';
import 'package:constellation_cafe/feature/guild_select/domain/guild.dart';
import 'package:constellation_cafe/feature/guild_select/notifier/guild_state_notifier.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/guild_tile_list.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/page_footer.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/page_header.dart';

import '../../../shared/widgets/loading/PageLoading.dart';
import '../constants/guild_constants.dart';

class GuildSelectPage extends ConsumerWidget {
  final Widget? child;

  const GuildSelectPage({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guildApi = ref.read(guildApiProvider);
    final guildStateNotifier = ref.read(
      currentGuildStateProvider.notifier,
    );

    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = ScreenWidth.isDesktop(width);

    return FutureBuilder<List<Guild>>(
      future: guildApi.findAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const PageLoading();
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('길드 목록을 불러오지 못했습니다.'),
            ),
          );
        }

        final guilds = snapshot.data ?? [];

        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ConstColor.gradientStart,
                  ConstColor.gradientEnd,
                ],
              ),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop
                    ? GuildConstants.desktopHorizontalPadding
                    : ConstPadding.mediumPadding,
                vertical: GuildConstants.verticalPadding,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isDesktop
                      ? GuildConstants.desktopMaxWidth
                      : GuildConstants.mobileMaxWidth,
                ),
                child: Column(
                  children: [
                    const SelectPageHeader(),
                    const SizedBox(
                      height: GuildConstants.headerListSpacing,
                    ),
                    GuildList(
                      guilds: guilds,
                      onGuildSelected: (guild) {
                        guildStateNotifier.setGuild(
                          guildId: guild.id,
                          guildName: guild.name,
                          guildIcon: guild.iconUrl,
                        );

                        context.go(
                          '/home?guild_id=${guild.id}',
                        );
                      },
                    ),
                    const SizedBox(
                      height: GuildConstants.listFooterSpacing,
                    ),
                    const SelectPageFooter(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}