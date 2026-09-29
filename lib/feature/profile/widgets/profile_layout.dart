import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';

import '../constants/profile_constants.dart';
import 'input_membership_data.dart';
import 'view_membership_card.dart';

/// 회원증과 멤버십 입력 폼 배치. 데스크톱은 나란히, 그 외에는 위아래로 둔다.
class ProfileLayout extends StatelessWidget {
  final bool isDesktop;
  final GlobalKey membershipCardKey;
  final GlobalKey pointLogButtonKey;
  final GlobalKey inputDataKey;

  const ProfileLayout({
    super.key,
    required this.isDesktop,
    required this.membershipCardKey,
    required this.pointLogButtonKey,
    required this.inputDataKey,
  });

  @override
  Widget build(BuildContext context) {
    final card = ViewMembershipCard(
      key: membershipCardKey,
      width: ProfileConstants.childWidgetWidth,
      pointLogButtonKey: pointLogButtonKey,
    );
    final input = InputMembershipData(
      key: inputDataKey,
      width: ProfileConstants.childWidgetWidth,
    );
    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          card,
          const SizedBox(width: ConstSize.mediumSpacing),
          input,
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        card,
        const SizedBox(height: ConstSize.mediumSpacing),
        input,
      ],
    );
  }
}
