
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/ScreenWidth/ScreenWidth.dart';
import '../../../../core/constants/ConstSize.dart';
import '../../../../core/widgets/loading/PageLoading.dart';
import '../../../../core/widgets/usage/usage.dart';
import '../../../../routes/login_check_notifier.dart';
import '../state/notifier/membership_notifier.dart';
import '../widgets/input_membership_data.dart';
import '../widgets/profile_usage.dart';
import '../widgets/view_membership_card.dart';


class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  final double childWidgetWidth = 400;

  final GlobalKey membershipCardKey = GlobalKey();
  final GlobalKey inputDataKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final login = ref.watch(loginCheckProvider);

    return login.when(
      loading: () => PageLoading(),
      error: (_, __) => PageLoading(),
      data: (isLoggedIn) {
        if (!isLoggedIn) return const SizedBox.shrink();

        final state = ref.watch(membershipProvider);
        if (state.isLoading) {
          return PageLoading();
        }

        print("Usage call");
        return Usage(
          usageKey: ProfileUsage.key,
          steps: ProfileUsage.steps(
            membershipCardKey: membershipCardKey,
            inputDataKey: inputDataKey,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              String deviceType =
              ScreenWidth.widthChecker(constraints.maxWidth);

              switch (deviceType) {
                case "mobileWidth":
                case "tabletWidth":
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ViewMembershipCard(
                        key: membershipCardKey,
                        width: childWidgetWidth,
                      ),
                      SizedBox(height: ConstSize.bigHeight),
                      InputMembershipData(
                        key: inputDataKey,
                        width: childWidgetWidth,
                      )
                    ],
                  );

                default:
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ViewMembershipCard(
                        key: membershipCardKey,
                        width: childWidgetWidth,
                      ),
                      SizedBox(width: ConstSize.bigWidth),
                      InputMembershipData(
                        key: inputDataKey,
                        width: childWidgetWidth,
                      )
                    ],
                  );
              }
            },
          ),
        );
      },
    );
  }
}