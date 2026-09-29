import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/const_shadow.dart';
import 'package:constellation_cafe/core/constants/const_size.dart';

import '../../guild_select/notifier/guild_state_notifier.dart';
import '../constants/profile_constants.dart';
import '../constants/profile_strings.dart';
import '../notifier/membership_notifier.dart';
import 'point_log_button.dart';

class ViewMembershipCard extends ConsumerWidget {
  final double width;
  final GlobalKey? pointLogButtonKey;

  const ViewMembershipCard({
    super.key,
    required this.width,
    this.pointLogButtonKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guild = ref.watch(currentGuildStateProvider);
    final state = ref.watch(membershipProvider);
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      child: Container(
        padding: ConstPadding.largePaddingAll,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(ProfileConstants.cardRadius),
          boxShadow: const [ConstShadow.card],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 회원증 상단
            Row(
              children: [
                // 프로필 사진
                ClipOval(
                  child: Image.network(
                    state.avatar,
                    width: ProfileConstants.profileImageSize,
                    height: ProfileConstants.profileImageSize,
                    fit: BoxFit.cover,
                    // 아바타 URL이 비었거나 깨지면 기본 사람 아이콘을 보여준다.
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.person,
                      size: ProfileConstants.profileImageSize,
                    ),
                  ),
                ),
                const SizedBox(width: ConstSize.mediumSpacing),

                // 닉네임
                Expanded(
                  child: Text(
                    ProfileStrings.cardTitle(state.username),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(width: ConstSize.mediumSpacing),

                // 길드 로고
                if (guild.guildIcon?.isNotEmpty ?? false)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      ProfileConstants.mainIconRadius,
                    ),
                    child: Image.network(
                      guild.guildIcon!,
                      width: ProfileConstants.mainIconSize,
                      height: ProfileConstants.mainIconSize,
                      fit: BoxFit.cover,
                      // 채팅방 아이콘을 불러오지 못하면 자리만 비워 둔다.
                      errorBuilder: (_, _, _) => const SizedBox.square(
                        dimension: ProfileConstants.mainIconSize,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: ConstSize.mediumSpacing),

            // UID / 역할 / 길드
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ProfileStrings.uid,
                        style: theme.textTheme.labelMedium,
                      ),
                      Text(
                        ProfileStrings.uidLine('s1', state.uid1),
                        style: theme.textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        ProfileStrings.uidLine('s2', state.uid2),
                        style: theme.textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                if (state.role?.isNotEmpty ?? false) ...[
                  const SizedBox(width: ConstSize.mediumSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ProfileStrings.role,
                          style: theme.textTheme.labelMedium,
                        ),
                        Text(
                          state.role!,
                          style: theme.textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],

                if (state.guild?.isNotEmpty ?? false) ...[
                  const SizedBox(width: ConstSize.mediumSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ProfileStrings.guild,
                          style: theme.textTheme.labelMedium,
                        ),
                        Text(
                          state.guild!,
                          style: theme.textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: ConstSize.mediumSpacing),

            // 대회 경력
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.s1Data?.isNotEmpty ?? false) ...[
                  Text(
                    ProfileStrings.s1Career,
                    style: theme.textTheme.labelMedium,
                  ),
                  Text(
                    state.s1Data!,
                    style: theme.textTheme.bodyMedium,
                    softWrap: true,
                  ),
                ],

                if (state.s2Data?.isNotEmpty ?? false) ...[
                  const SizedBox(height: ConstSize.mediumSpacing),
                  Text(
                    ProfileStrings.s2Career,
                    style: theme.textTheme.labelMedium,
                  ),
                  Text(
                    state.s2Data!,
                    style: theme.textTheme.bodyMedium,
                    softWrap: true,
                  ),
                ],
              ],
            ),

            const SizedBox(height: ConstSize.mediumSpacing),

            // 포인트 로그 / 발급 일자
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PointLogButton(
                  key: pointLogButtonKey,
                  state: state,
                  theme: theme.textTheme,
                ),
                const SizedBox(width: ConstSize.mediumSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ProfileStrings.joinAt,
                        style: theme.textTheme.labelMedium,
                      ),
                      Text(
                        state.joinAt,
                        style: theme.textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: ConstSize.mediumSpacing),

            Text(
              ProfileStrings.uidWarning,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
