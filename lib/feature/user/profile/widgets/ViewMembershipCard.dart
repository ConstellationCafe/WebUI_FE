// flutter
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Provider
import '../state/Provider/StateProvider.dart';
// Const
import 'package:constellation_cafe/core/constants/ConstPadding.dart';

class ViewMembershipCard extends ConsumerWidget {
  final double width;

  const ViewMembershipCard({
    super.key,
    required this.width
  });

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    final state = ref.watch(membershipProvider);

    return SizedBox(
      width: width,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: ConstPadding.bigPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            // 회원증 상단
            Row(
              // mainAxisSize: MainAxisSize.max,
              children: [
                // 프로필 사진
                ClipOval(
                  child: Image.network(
                    state.avatar,
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: ConstPadding.mediumPadding),
                //닉네임
                Expanded(
                    child: Text(
                      "${state.username}님의 회원증",
                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                ),
                SizedBox(width: ConstPadding.mediumPadding),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    "assets/icons/main_icon.jpg",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            // 역할, 포인트, 길드, 발급 일자를 Table로 정리
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("UID"),
                    Text(
                      (state.uid1?.isNotEmpty ?? false)
                          ? "S1 : ${state.uid1}"
                          : "S1 : 미등록",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    Text(
                      (state.uid2?.isNotEmpty ?? false)
                          ? "S2 : ${state.uid2}"
                          : "S2 : 미등록",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
                if (state.role?.isNotEmpty ?? false) ... [
                  SizedBox(width: ConstPadding.mediumPadding),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("역할"),
                        Text(state.role!)
                      ]
                  )
                ],
                if (state.guild?.isNotEmpty ?? false) ... [
                  SizedBox(width: ConstPadding.mediumPadding),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("길드"),
                        Text(state.guild!),
                      ]
                  )
                ]
              ],
            ),
            SizedBox(height: ConstPadding.mediumPadding),
            // 대회 경력
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (state.s1Data?.isNotEmpty ?? false) ... [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("S1 경력"),
                      Text(
                          state.s1Data!,
                          softWrap: true,
                          overflow: TextOverflow.visible
                      )
                    ],
                  )
                ],
                if (state.s2Data?.isNotEmpty ?? false) ... [
                  SizedBox(height: ConstPadding.mediumPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("S2 경력"),
                      Text(
                          state.s2Data!,
                          softWrap: true,
                          overflow: TextOverflow.visible
                      )
                    ],
                  )
                ],
              ],
            ),
            SizedBox(height: ConstPadding.mediumPadding),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("별자리 포인트"),
                    Text(state.coin)
                  ],
                ),
                SizedBox(width: ConstPadding.mediumPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "발급 일자",
                        softWrap: true,
                        overflow: TextOverflow.visible
                    ),
                    Text(
                        state.joinAt,
                        softWrap: true,
                        overflow: TextOverflow.visible
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: ConstPadding.mediumPadding),
            Text(
                "* UID의 허위 기재 및 도용시 처벌받을 수 있습니다",
                softWrap: true,
                overflow: TextOverflow.visible
            )
          ],
        ),
      ),
    );
  }
}
