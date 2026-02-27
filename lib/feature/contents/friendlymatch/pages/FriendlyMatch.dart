
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/ConstSize.dart';
import '../../../../core/constants/ScreenWidth/ScreenWidth.dart';
import '../widgets/InputFreindlyMatch.dart';
import '../widgets/ViewFriendlyMatch.dart';


class FriendlyMatch extends ConsumerWidget {
  final double childWidgetWidth = 400;

  const FriendlyMatch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        String deviceType = ScreenWidth.widthChecker(constraints.maxWidth);

        switch (deviceType) {
          case "mobileWidth":
          case "tabletWidth":
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ViewFriendlyMatch(width: childWidgetWidth),
                SizedBox(height: ConstSize.bigHeight),
                InputFriendlyMatch(width: childWidgetWidth),
              ],
            );
          default:
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ViewFriendlyMatch(width: childWidgetWidth),
                SizedBox(width: ConstSize.bigWidth),
                InputFriendlyMatch(width: childWidgetWidth),
              ],
            );
        }  // switch
      },
    );
  }
}