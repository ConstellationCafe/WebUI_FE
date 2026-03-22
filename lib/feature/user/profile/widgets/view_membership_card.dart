// flutter
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Provider
import '../state/Notifier/membership_notifier.dart';
// Const
import 'package:constellation_cafe/core/constants/ConstPadding.dart';
import 'package:constellation_cafe/core/constants/ConstSize.dart';

class ViewMembershipCard extends ConsumerWidget {
  final double width;

  const ViewMembershipCard({
    super.key,
    required this.width
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(membershipProvider);
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: ConstPadding.largePaddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 회원증 상단
              Row(
                children: [
                  // 프로필 사진
                  ClipOval(
                    child: Image.network(
                      state.avatar,
                      width: 32, // 8의 배수
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: ConstSize.mediumSpacing),
                  //닉네임
                  Expanded(
                      child: Text(
                        "${state.username}님의 회원증",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                  ),
                  SizedBox(width: ConstSize.mediumSpacing),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8), // 8의 배수
                    child: Image.asset(
                      "assets/icons/main_icon.jpg",
                      width: 40, // 8의 배수
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              SizedBox(height: ConstSize.mediumSpacing),
              // 역할, 포인트, 길드, 발급 일자를 Table로 정리
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("UID", style: theme.textTheme.labelMedium),
                      Text(
                        (state.uid1?.isNotEmpty ?? false)
                            ? "s1 : ${state.uid1}"
                            : "s1 : 미등록",
                        style: theme.textTheme.bodyMedium,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                      Text(
                        (state.uid2?.isNotEmpty ?? false)
                            ? "s2 : ${state.uid2}"
                            : "s2 : 미등록",
                        style: theme.textTheme.bodyMedium,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                  if (state.role?.isNotEmpty ?? false) ... [
                    SizedBox(width: ConstSize.mediumSpacing),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("역할", style: theme.textTheme.labelMedium),
                          Text(state.role!, style: theme.textTheme.bodyMedium)
                        ]
                    )
                  ],
                  if (state.guild?.isNotEmpty ?? false) ... [
                    SizedBox(width: ConstSize.mediumSpacing),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("길드", style: theme.textTheme.labelMedium),
                          Text(state.guild!, style: theme.textTheme.bodyMedium),
                        ]
                    )
                  ]
                ],
              ),
              SizedBox(height: ConstSize.mediumSpacing),
              // 대회 경력
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (state.s1Data?.isNotEmpty ?? false) ... [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("s1 경력", style: theme.textTheme.labelMedium),
                        Text(
                            state.s1Data!,
                            style: theme.textTheme.bodyMedium,
                            softWrap: true,
                            overflow: TextOverflow.visible
                        )
                      ],
                    )
                  ],
                  if (state.s2Data?.isNotEmpty ?? false) ... [
                    SizedBox(height: ConstSize.mediumSpacing),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("s2 경력", style: theme.textTheme.labelMedium),
                        Text(
                            state.s2Data!,
                            style: theme.textTheme.bodyMedium,
                            softWrap: true,
                            overflow: TextOverflow.visible
                        )
                      ],
                    )
                  ],
                ],
              ),
              SizedBox(height: ConstSize.mediumSpacing),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("별자리 포인트", style: theme.textTheme.labelMedium),
                      Text(state.coin, style: theme.textTheme.bodyMedium)
                    ],
                  ),
                  SizedBox(width: ConstSize.mediumSpacing),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "발급 일자",
                          style: theme.textTheme.labelMedium,
                          softWrap: true,
                          overflow: TextOverflow.visible
                      ),
                      Text(
                          state.joinAt,
                          style: theme.textTheme.bodyMedium,
                          softWrap: true,
                          overflow: TextOverflow.visible
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: ConstSize.mediumSpacing),
              Text(
                  "* UID의 허위 기재 및 도용시 처벌받을 수 있습니다",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible
              )
            ],
          ),
        ),
      ),
    );
  }
}
