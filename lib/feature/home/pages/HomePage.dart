import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/ConstPadding.dart';
import '../../../core/constants/ScreenWidth/ScreenWidth.dart';
import '../../../core/widgets/MenuBarArea/MainMenuBar.dart';
import '../../../core/widgets/appbar/MainAppBar.dart';
import '../../../routes/LoginCheckProvider.dart';
import '../widgets/ProfileMenu.dart';

class HomePage extends ConsumerWidget {
  final Widget? child;

  const HomePage({super.key, this.child});

  bool _isDesktop(String deviceType) => deviceType != "mobileWidth";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceType = ScreenWidth.widthChecker(MediaQuery.sizeOf(context).width);
    final isDesktop = _isDesktop(deviceType);
    final login = ref.watch(loginCheckProvider);

    return login.when(
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
        data: (isLoggedIn) {
          if (!isLoggedIn) return const SizedBox.shrink();
          return Scaffold(
            drawer: isDesktop
                ? null
                : SizedBox(
              width: 180,
              child: Drawer(
                child: Padding(
                  padding: ConstPadding.bigPaddingAll,
                  child: MainMenuBar(),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(
                ConstPadding.bigPadding,
                ConstPadding.bigPadding,
                ConstPadding.bigPadding,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상단(고정)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (scaffoldContext) => MainAppBar(
                          showMenuButton: !isDesktop,
                          onMenuPressed: () => Scaffold.of(scaffoldContext).openDrawer(),
                        ),
                      ),
                      ProfileMenu(),
                    ],
                  ),
                  const SizedBox(height: ConstPadding.tinyPadding),
                  const Divider(thickness: 1, color: Colors.grey),
                  const SizedBox(height: ConstPadding.tinyPadding),

                  // 아래(남은 영역)
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isDesktop) ...[
                          MainMenuBar(),
                          const SizedBox(width: 10),
                        ],

                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              // "화면보다 작으면 가운데 / 크면 위 + 스크롤"을 확실히 만들려면
                              // 스크롤 child를 최소높이=viewport로 만들고,
                              // 그 안에서 Alignment.center로 정렬해야 합니다.
                              return SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center, // <-- 여기 중요
                                    child: child ?? const SizedBox.shrink(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
