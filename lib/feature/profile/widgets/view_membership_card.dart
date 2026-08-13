import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/core/constants/const_shadow.dart';
import 'package:constellation_cafe/core/constants/const_size.dart';

import '../../guild_select/notifier/guild_state_notifier.dart';
import '../constants/profile_constants.dart';
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
          borderRadius: BorderRadius.circular(
            ProfileConstants.cardRadius,
          ),
          boxShadow: const [
            ConstShadow.card,
          ],
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
                  ),
                ),
                const SizedBox(
                  width: ConstSize.mediumSpacing,
                ),

                // 닉네임
                Expanded(
                  child: Text(
                    '${state.username}님의 회원증',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(
                  width: ConstSize.mediumSpacing,
                ),

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
                    ),
                  ),
              ],
            ),

            const SizedBox(
              height: ConstSize.mediumSpacing,
            ),

            // UID / 역할 / 길드
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'UID',
                        style: theme.textTheme.labelMedium,
                      ),
                      Text(
                        (state.uid1?.isNotEmpty ?? false)
                            ? 's1 : ${state.uid1}'
                            : 's1 : 미등록',
                        style: theme.textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        (state.uid2?.isNotEmpty ?? false)
                            ? 's2 : ${state.uid2}'
                            : 's2 : 미등록',
                        style: theme.textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                if (state.role?.isNotEmpty ?? false) ...[
                  const SizedBox(
                    width: ConstSize.mediumSpacing,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '역할',
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
                  const SizedBox(
                    width: ConstSize.mediumSpacing,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '길드',
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

            const SizedBox(
              height: ConstSize.mediumSpacing,
            ),

            // 대회 경력
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.s1Data?.isNotEmpty ?? false) ...[
                  Text(
                    's1 경력',
                    style: theme.textTheme.labelMedium,
                  ),
                  Text(
                    state.s1Data!,
                    style: theme.textTheme.bodyMedium,
                    softWrap: true,
                  ),
                ],

                if (state.s2Data?.isNotEmpty ?? false) ...[
                  const SizedBox(
                    height: ConstSize.mediumSpacing,
                  ),
                  Text(
                    's2 경력',
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

            const SizedBox(
              height: ConstSize.mediumSpacing,
            ),

            // 포인트 로그 / 발급 일자
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PointLogButton(
                  key: pointLogButtonKey,
                  state: state,
                  theme: theme.textTheme,
                ),
                const SizedBox(
                  width: ConstSize.mediumSpacing,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '발급 일자',
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

            const SizedBox(
              height: ConstSize.mediumSpacing,
            ),

            Text(
              '* UID의 허위 기재 및 도용시 처벌받을 수 있습니다',
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