
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/ConstPadding.dart';
import '../../../core/widgets/MenuBarArea/MainMenuBar.dart';
import '../../../core/widgets/appbar/MainAppBar.dart';
import '../widgets/ProfileMenu.dart';


class HomePage extends ConsumerWidget {
  final Widget? child;

  const HomePage({super.key, this.child});

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsGeometry.fromLTRB(
              ConstPadding.bigPadding, ConstPadding.bigPadding, ConstPadding.bigPadding, 0
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainAppBar(),
                  ProfileMenu()
                ],
              ),
              SizedBox(height: 5),
              // 경계
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              // 내용물
              Row(
                  children: [
                    MainMenuBar(),
                    SizedBox(width: 10),
                    // 중첩 라우트 컨텐츠 표시
                    if (child != null) ...[
                      Expanded(
                        child: Center(
                          child: child!,
                        ),
                      ),
                    ]
                  ]
                )
              ],
            ),
          ),
        ),
      );
  }
}
