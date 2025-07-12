import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Container/Container01.dart';

class MainCategory extends ConsumerStatefulWidget {
  const MainCategory({super.key});

  @override
  ConsumerState<MainCategory> createState() => _MainCategoryState();
}

class _MainCategoryState extends ConsumerState<MainCategory> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 친선전
        Container01(icon: Icon(Icons.handshake_sharp, color: Colors.black54), text: "친선전"),
        Spacer(),
        // 공략
        Container01(icon: Icon(Icons.light_mode, color: Colors.black54), text: "공략"),
        Spacer(),
        // 통계
        Container01(icon: Icon(Icons.query_stats, color: Colors.black54), text: "통계"),
      ],
    );
  }
}
