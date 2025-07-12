import 'package:constellation_cafe/Constant/ConstPadding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Components/CommonComponent/AppBarArea/AppBar.dart';
import '../../Components/ProfileIcon/ProfileIcon.dart';
import '../../Components/HomePageComponent/MainCategoryArea/MainCategory/MainCategory.dart';
import '../../Components/HomePageComponent/MainCategoryArea/MainSearchBar/MainSearchBar.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  final Widget? child;

  const HomePage({super.key, this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: 1000,
        padding: EdgeInsetsGeometry.fromLTRB(
            ConstPadding.bigPadding,
            ConstPadding.bigPadding,
            ConstPadding.bigPadding,
            0
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainAppBar(),
                ProfileIcon(
                  onTap: () {
                    // Profile 아이콘 클릭 시 ProfilePage로 이동
                    context.go('/profile');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MainCategory(),
                ),
                MainSearchBar(),
              ],
            ),
            // 중첩 라우트 컨텐츠 표시
            if (child != null)
              Expanded(
                child: child!,
              ),
          ],
        ),
      ),
    );
  }
}