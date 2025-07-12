import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Container/Container01.dart';



class MainCategory extends ConsumerStatefulWidget {
  const MainCategory({super.key});

  @override
  ConsumerState<MainCategory> createState() => _MainCategoryState();
}

class _MainCategoryState extends ConsumerState<MainCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 친선전
          Container01(iconImage: Image.asset("assets/Icons/web/swords.png"), text: "친선전"),
          Container01(iconImage: Image.asset("assets/Icons/web/swords.png"), text: "친선전2"),
          Container01(iconImage: Image.asset("assets/Icons/web/swords.png"), text: "친선전3"),
        ],
      ),
    );
  }
}
