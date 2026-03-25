
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/ScreenWidth/ScreenWidth.dart';
import '../../../../core/constants/ConstSize.dart';
import '../../../../core/widgets/loading/PageLoading.dart';
import '../../../../routes/login_check_notifier.dart';
import '../state/notifier/membership_notifier.dart';
import '../widgets/input_membership_data.dart';
import '../widgets/view_membership_card.dart';


class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  final double childWidgetWidth = 400;

  @override
  Widget build(BuildContext context) {
    final login = ref.watch(loginCheckProvider);
    
    return login.when(
      loading: () => PageLoading(),
      error: (_, __) => PageLoading(),
      data: (isLoggedIn) {
        if (!isLoggedIn) return const SizedBox.shrink();

        final state = ref.watch(membershipProvider);
        // MEMO : 현재는 build시마다 initialize() 호출
        final notifier = ref.watch(membershipProvider.notifier);
        notifier.initialize();

        if (state.isLoading) {
          return PageLoading();
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            String deviceType = ScreenWidth.widthChecker(constraints.maxWidth);
            switch (deviceType) {
              case "mobileWidth":
              case "tabletWidth":
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ViewMembershipCard(width: childWidgetWidth),
                    SizedBox(height: ConstSize.bigHeight),
                    InputMembershipData(width: childWidgetWidth)
                  ],
                );
              default:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ViewMembershipCard(width: childWidgetWidth),
                    SizedBox(width: ConstSize.bigWidth),
                    InputMembershipData(width: childWidgetWidth)
                  ],
                );
            }  // switch
          },
        );
      },
    );
  }
}
