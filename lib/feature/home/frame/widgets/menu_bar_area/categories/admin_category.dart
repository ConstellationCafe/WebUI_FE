import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'Container/menu_container.dart';

class AdminCategory extends ConsumerWidget {
  const AdminCategory({super.key});

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
              textAlign: TextAlign.left,
              "관리자 메뉴"
          ),
          SizedBox(height: ConstSize.tinyWidth),
          MenuContainer(
            iconImage: Image.asset(
              "assets/icons/category/admin/point.png",
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high
            ),
            menuName: "포인트 관리",
            callbackUrl: "/point",
          ),
        ]
    );
  }
}