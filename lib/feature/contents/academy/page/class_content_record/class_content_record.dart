
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/ConstSize.dart';
import 'package:constellation_cafe/core/constants/ScreenWidth/ScreenWidth.dart';
import 'package:constellation_cafe/shared/widgets/usage/usage.dart';
import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';

class ClassContentRecord extends ConsumerStatefulWidget {
  const ClassContentRecord({super.key});

  @override
  ConsumerState<ClassContentRecord> createState() => _ClassContentRecordState();
}

class _ClassContentRecordState extends ConsumerState<ClassContentRecord> {
  final double childWidgetWidth = 400;

  // final GlobalKey submitKey = GlobalKey();
  // final GlobalKey inputDataKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final login = ref.watch(loginCheckProvider);
    return login.when(
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
        data: (isLoggedIn) {
          if (!isLoggedIn) return const SizedBox.shrink();
          // TODO : Usage(사용설명서) 추가
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
                      // ViewClassContentRecord(
                      //     submitKey: submitKey,
                      //     width: childWidgetWidth
                      // ),
                      // SizedBox(height: ConstSize.bigHeight),
                      // InputClassContentRecord(
                      //     key: inputDataKey,
                      //     width: childWidgetWidth
                      // ),
                    ],
                  );
                default:
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ViewClassContentRecord(
                      //     submitKey: submitKey,
                      //     width: childWidgetWidth
                      // ),
                      // SizedBox(width: ConstSize.bigWidth),
                      // InputClassContentRecord(
                      //     key: inputDataKey,
                      //     width: childWidgetWidth
                      // ),
                    ],
                  );
              }  // switch
            },
          );
        }
    );
  }
}