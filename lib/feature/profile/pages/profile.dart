import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/core/constants/screen_width.dart';
import 'package:constellation_cafe/shared/widgets/loading/PageLoading.dart';
import 'package:constellation_cafe/shared/widgets/usage/usage.dart';

import '../constants/profile_constants.dart';
import '../notifier/membership_notifier.dart';
import '../widgets/input_membership_data.dart';
import '../widgets/profile_usage.dart';
import '../widgets/view_membership_card.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  final GlobalKey membershipCardKey = GlobalKey();
  final GlobalKey pointLogButtonKey = GlobalKey();
  final GlobalKey inputDataKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(membershipProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(membershipProvider);

    if (state.isLoading) {
      return const PageLoading();
    }

    return Usage(
      usageKey: ProfileUsage.key,
      steps: ProfileUsage.steps(
        pointLogButtonKey: pointLogButtonKey,
        inputDataKey: inputDataKey,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final deviceType = ScreenWidth.widthChecker(
            constraints.maxWidth,
          );

          final content = [
            ViewMembershipCard(
              key: membershipCardKey,
              width: ProfileConstants.childWidgetWidth,
              pointLogButtonKey: pointLogButtonKey,
            ),
            const SizedBox(
              width: ConstSize.mediumSpacing,
            ),
            InputMembershipData(
              key: inputDataKey,
              width: ProfileConstants.childWidgetWidth,
            ),
          ];

          if (deviceType == ScreenWidth.mobile ||
              deviceType == ScreenWidth.tablet) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  content[0],
                  const SizedBox(
                    height: ConstSize.mediumSpacing,
                  ),
                  content[2],
                ],
              ),
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content,
              ),
            ),
          );
        },
      ),
    );
  }
}