import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/const_color.dart';
import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/di/ApiProvider.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';
import 'package:constellation_cafe/feature/guild_select/notifier/guild_state_notifier.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/guild_tile_list.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/page_footer.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/page_header.dart';
import 'package:constellation_cafe/feature/guild_select/provider/guild_list_provider.dart';
import '../../../shared/widgets/loading/PageLoading.dart';
import '../constants/guild_constants.dart';

class GuildSelectPage extends ConsumerWidget {
  final Widget? child;

  const GuildSelectPage({super.key, this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guildsAsync = ref.watch(guildListProvider);

    final guildStateNotifier = ref.read(currentGuildStateProvider.notifier);

    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = ScreenWidth.isDesktop(width);

    return guildsAsync.when(
      loading: () => const PageLoading(),

      error: (error, stack) {
        return const Scaffold(body: Center(child: Text('길드 목록을 불러오지 못했습니다.')));
      },

      data: (guilds) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [ConstColor.gradientStart, ConstColor.gradientEnd],
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

                    const SizedBox(height: GuildConstants.headerListSpacing),

                    GuildList(
                      guilds: guilds,
                      onGuildSelected: (guild) async {
                        // ADR-0001: 채팅방을 선택해야 로그인이 완료된다.
                        // 백엔드가 이 discordId를 그 방의 멤버로 확인해줘야
                        // botId가 실린 토큰이 발급되므로, 로컬 상태만 바꾸고
                        // 넘어가면 이후 /api/**가 전부 401난다.
                        final guildApi = ref.read(guildApiProvider);
                        bool selected;
                        try {
                          selected = await guildApi.selectGuild(guild.id);
                        } catch (_) {
                          selected = false;
                        }

                        if (!selected) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  '이 채팅방을 선택할 수 없습니다. 멤버 여부를 확인해주세요.',
                                ),
                              ),
                            );
                          }
                          return;
                        }

                        guildStateNotifier.setGuild(
                          guildId: guild.id,
                          guildName: guild.name,
                          guildIcon: guild.iconUrl,
                        );

                        // 새로 발급된(botId 포함) 토큰을 기준으로
                        // 로그인 상태(roomSelected)를 다시 확인한다.
                        await ref.read(loginCheckProvider.notifier).recheck();

                        // roles(관리자 여부)는 방 단위로 갈리므로, 이미
                        // 초기화되어 있던 경우(재선택/방 변경)에도 새 방
                        // 기준으로 강제로 다시 불러온다.
                        await ref
                            .read(currentUserStateProvider.notifier)
                            .refresh();

                        if (context.mounted) {
                          context.go('/home?guild_id=${guild.id}');
                        }
                      },
                    ),

                    const SizedBox(height: GuildConstants.listFooterSpacing),

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
