import 'package:constellation_cafe/feature/profile/state/membership_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PointLogButton extends StatelessWidget {
  final MembershipState state;
  final TextTheme theme;

  const PointLogButton({
    super.key,
    required this.state,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push("/point_log"),
        borderRadius: BorderRadius.circular(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("별자리 포인트", style: theme.labelMedium),
            Text(state.coin, style: theme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
