import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/di/ApiProvider.dart';
// import '../../../core/constants/ConstPadding.dart';
import '../../../core/constants/ScreenWidth/ScreenWidth.dart';
import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';
import 'package:constellation_cafe/feature/guild_select/domain/guild.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/guild_tile_list.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/page_footer.dart';
import 'package:constellation_cafe/feature/guild_select/widgets/page_header.dart';


class GuildSelectPage extends ConsumerWidget {
  final Widget? child;

  const GuildSelectPage({
    super.key,
    this.child,
  });

  bool _isDesktop(String deviceType) {
    return deviceType != "mobileWidth";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceType = ScreenWidth.widthChecker(
      MediaQuery
          .sizeOf(context)
          .width,
    );
    final isDesktop = _isDesktop(deviceType);
    final login = ref.watch(loginCheckProvider);
    final guildApi = ref.read(guildApiProvider);
    return login.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (isLoggedIn) {
        return FutureBuilder<List<Guild>>(
          future: guildApi.findAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '길드 목록을 불러오지 못했습니다.',
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
                      Color(0xFFF5F7FA),
                      Color(0xFFC3CFE2),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 24 : 16,
                        vertical: 40,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isDesktop ? 760 : 600,
                        ),
                        child: Column(
                          children: [
                            const SelectPageHeader(),
                            const SizedBox(height: 36),

                            GuildList(
                              guilds: guilds,
                              onGuildSelected: (guild) {
                                context.go(
                                  '/home?guild_id=${guild.id}',
                                );
                              },
                            ),

                            const SizedBox(height: 28),
                            const SelectPageFooter(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}