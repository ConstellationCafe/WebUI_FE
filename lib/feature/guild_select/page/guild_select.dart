import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/const_color.dart';
import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/feature/guild_select/api/guild_api.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';
import 'package:constellation_cafe/feature/guild_select/notifier/guild_state_notifier.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/guild_tile_list.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/page_footer.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/page_header.dart';
import 'package:constellation_cafe/feature/guild_select/provider/guild_list_provider.dart';

import '../../../shared/widgets/loading/PageLoading.dart';
import '../constants/guild_constants.dart';
import '../constants/guild_select_strings.dart';

class GuildSelectPage extends ConsumerStatefulWidget {
  final Widget? child;

  const GuildSelectPage({super.key, this.child});

  @override
  ConsumerState<GuildSelectPage> createState() => _GuildSelectPageState();
}

class _GuildSelectPageState extends ConsumerState<GuildSelectPage> {
  String? _selectingGuildId;

  @override
  Widget build(BuildContext context) {
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

                    if (_selectingGuildId != null)
                      const Semantics(
                        liveRegion: true,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: GuildConstants.selectionMessageGap,
                          ),
                          child: Text(GuildSelectStrings.connecting),
                        ),
                      ),

                    GuildList(
                      guilds: guilds,
                      selectingGuildId: _selectingGuildId,
                      onGuildSelected: (guild) async {
                        if (_selectingGuildId != null) return;
                        setState(() => _selectingGuildId = guild.id);

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

                        if (!mounted) return;
                        if (!selected) {
                          setState(() => _selectingGuildId = null);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(GuildSelectStrings.selectionFailed),
                            ),
                          );
                          return;
                        }

                        // 이전 채팅방의 사용자 역할과 학원 권한을 지운 다음,
                        // 재확인 과정에서 새 방의 정보를 한 번만 불러온다.
                        ref.read(currentUserStateProvider.notifier).clear();
                        guildStateNotifier.setGuild(
                          guildId: guild.id,
                          guildName: guild.name,
                          guildIcon: guild.iconUrl,
                        );

                        // 새로 발급된(botId 포함) 토큰을 기준으로
                        // 로그인 상태(roomSelected)를 다시 확인한다.
                        await ref.read(loginCheckProvider.notifier).recheck();
                        if (!mounted) return;
                        if (ref.read(loginCheckProvider).value?.roomSelected !=
                            true) {
                          setState(() => _selectingGuildId = null);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(GuildSelectStrings.checkFailed),
                            ),
                          );
                          return;
                        }
                        context.go('/home?guild_id=${guild.id}');
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
