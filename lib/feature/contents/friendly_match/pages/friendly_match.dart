
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/ConstSize.dart';
import 'package:constellation_cafe/core/constants/ScreenWidth/ScreenWidth.dart';
import 'package:constellation_cafe/shared/widgets/usage/usage.dart';
import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';
import '../widgets/input_friendly_match.dart';
import '../widgets/view_friendly_match.dart';
import '../widgets/friendly_match_usage.dart';

class FriendlyMatch extends ConsumerStatefulWidget {
  const FriendlyMatch({super.key});

  @override
  ConsumerState<FriendlyMatch> createState() => _FriendlyMatchState();
}

class _FriendlyMatchState extends ConsumerState<FriendlyMatch> {
  final double childWidgetWidth = 400;

  final GlobalKey submitKey = GlobalKey();
  final GlobalKey inputDataKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final login = ref.watch(loginCheckProvider);
    return login.when(
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
        data: (isLoggedIn) {
          if (!isLoggedIn) return const SizedBox.shrink();
          return Usage(
              usageKey: FriendlyMatchUsage.key,
              steps: FriendlyMatchUsage.steps(
                submitKey: submitKey,
                inputDataKey: inputDataKey,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  String deviceType = ScreenWidth.widthChecker(constraints.maxWidth);

                  switch (deviceType) {
                    case "mobileWidth":
                    case "tabletWidth":
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ViewFriendlyMatch(
                              submitKey: submitKey,
                              width: childWidgetWidth
                          ),
                          SizedBox(height: ConstSize.bigHeight),
                          InputFriendlyMatch(
                              key: inputDataKey,
                              width: childWidgetWidth
                          ),
                        ],
                      );
                    default:
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ViewFriendlyMatch(
                              submitKey: submitKey,
                              width: childWidgetWidth
                          ),
                          SizedBox(width: ConstSize.bigWidth),
                          InputFriendlyMatch(
                              key: inputDataKey,
                              width: childWidgetWidth
                          ),
                        ],
                      );
                  }  // switch
                },
              )
          );
        }
    );
  }
}