import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/const_color.dart';
import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/feature/guild_select/domain/type/guild_selection_result.dart';
import 'package:constellation_cafe/feature/guild_select/notifier/guild_list_provider.dart';
import 'package:constellation_cafe/feature/guild_select/notifier/guild_state_notifier.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/guild_tile_list.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/page_footer.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/page_header.dart';
import 'package:constellation_cafe/shared/widgets/loading/page_loading.dart';

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

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final guildsAsync = ref.watch(guildListProvider);

    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = ScreenWidth.isDesktop(width);

    return guildsAsync.when(
      loading: () => const PageLoading(),

      error: (error, stack) {
        return const Scaffold(
          body: Center(child: Text(GuildSelectStrings.loadFailed)),
        );
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
                      Semantics(
                        liveRegion: true,
                        child: const Padding(
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

                        final result = await ref
                            .read(currentGuildStateProvider.notifier)
                            .select(guild);

                        if (!context.mounted) return;
                        switch (result) {
                          case GuildSelectionResult.selected:
                            context.go('/home?guild_id=${guild.id}');
                          case GuildSelectionResult.rejected:
                            setState(() => _selectingGuildId = null);
                            _showMessage(GuildSelectStrings.selectionFailed);
                          case GuildSelectionResult.checkFailed:
                            setState(() => _selectingGuildId = null);
                            _showMessage(GuildSelectStrings.checkFailed);
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
