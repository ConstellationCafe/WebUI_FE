import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/profile_constants.dart';
import '../constants/profile_strings.dart';
import '../state/membership_state.dart';

class PointLogButton extends StatelessWidget {
  final MembershipState state;
  final TextTheme theme;

  const PointLogButton({super.key, required this.state, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push("/point_log"),
        borderRadius: BorderRadius.circular(
          ProfileConstants.pointLogButtonRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ProfileStrings.point, style: theme.labelMedium),
            Text(state.coin, style: theme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
