import 'package:constellation_cafe/Constant/ConstPadding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Components/CommonComponent/AppBarArea/AppBar.dart';
import '../Components/CustomIcon/CustomIcon01.dart';
import '../Components/HomePageComponent/MainCategoryArea/MainCategory/MainCategory.dart';
import '../Components/HomePageComponent/MainCategoryArea/MainSearchBar/MainSearchBar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: 1000,
        padding:
            EdgeInsetsGeometry.fromLTRB(ConstPadding.bigPadding, ConstPadding.bigPadding, ConstPadding.bigPadding, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainAppBar(),
                CustomIcon01(),
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
            )
          ],
        ),
      ),
    );
  }
}
