import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../Container/Container01.dart';

class MainCategory extends ConsumerStatefulWidget {
  const MainCategory({super.key});

  @override
  ConsumerState<MainCategory> createState() => _MainCategoryState();
}

class _MainCategoryState extends ConsumerState<MainCategory> {
  @override
  Widget build(BuildContext build) {
    return Container(
      width: 800,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 친선전
          Container01(
              iconImage: Image.asset("assets/icons/web/swords.png"),
              text: "친선전",
              onTap: () {
                build.go("/friendly_match");
              }),
          Container01(
              iconImage: Image.asset("assets/icons/web/swords.png"),
              text: "친선전2",
              onTap: () {
                build.go("/friendly_match");
              }),
          Container01(
              iconImage: Image.asset("assets/icons/web/swords.png"),
              text: "친선전3",
              onTap: () {
                build.go("/friendly_match");
              }),
        ],
      ),
    );
  }
}
