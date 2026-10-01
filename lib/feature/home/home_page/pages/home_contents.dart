import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/guild_select/notifier/guild_state_notifier.dart';
import 'package:constellation_cafe/feature/home/constants/home_constants.dart';
import 'package:constellation_cafe/feature/home/constants/home_strings.dart';

import '../widgets/home_action_card.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guildName = ref.watch(currentGuildStateProvider).guildName;
    final username = ref.watch(currentUserStateProvider).globalName;
    final title = guildName.isEmpty
        ? HomeStrings.welcome
        : HomeStrings.welcomeTo(guildName);
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = min(constraints.maxWidth, HomeConstants.contentMaxWidth);
        final stacked = width < HomeConstants.actionStackBreakpoint;
        final actionWidth = stacked
            ? width
            : (width - ConstSize.mediumSpacing * 2) / 3;

        return SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: ConstPadding.largePadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      color: HomeConstants.heroBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          HomeConstants.cardRadius,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          ConstPadding.largePadding,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Semantics(
                                    header: true,
                                    child: Text(
                                      title,
                                      style: theme.textTheme.headlineSmall
                                          ?.copyWith(
                                            color: HomeConstants.heroForeground,
                                          ),
                                    ),
                                  ),
                                  if (username.isNotEmpty) ...[
                                    const SizedBox(
                                      height: ConstSize.smallSpacing,
                                    ),
                                    Text(
                                      username,
                                      style: theme.textTheme.titleMedium,
                                    ),
                                  ],
                                  const SizedBox(
                                    height: ConstSize.smallSpacing,
                                  ),
                                  Text(
                                    HomeStrings.introduction,
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: ConstSize.mediumSpacing),
                            const Icon(
                              Icons.auto_awesome_outlined,
                              size: HomeConstants.heroIconSize,
                              color: HomeConstants.heroForeground,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: ConstSize.largeSpacing),
                    Semantics(
                      header: true,
                      child: Text(
                        HomeStrings.quickLinks,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: ConstSize.mediumSpacing),
                    Wrap(
                      spacing: ConstSize.mediumSpacing,
                      runSpacing: ConstSize.mediumSpacing,
                      children: [
                        HomeActionCard(
                          width: actionWidth,
                          icon: Icons.person_outline,
                          title: HomeStrings.profile,
                          description: HomeStrings.profileDescription,
                          onTap: () => context.go('/profile'),
                        ),
                        HomeActionCard(
                          width: actionWidth,
                          icon: Icons.fact_check_outlined,
                          title: HomeStrings.penalties,
                          description: HomeStrings.penaltiesDescription,
                          onTap: () => context.go('/my-penalties'),
                        ),
                        HomeActionCard(
                          width: actionWidth,
                          icon: Icons.swap_horiz_rounded,
                          title: HomeStrings.selectGuild,
                          description: HomeStrings.selectGuildDescription,
                          onTap: () => context.go('/select'),
                        ),
                      ],
                    ),
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
