import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/ConstSize.dart';
import '../Container/MenuContainer.dart';

class AcademyCategory extends ConsumerWidget {
  const AcademyCategory({super.key});

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
              textAlign: TextAlign.left,
              "아카데미 메뉴"
          ),
          SizedBox(height: ConstSize.tinyWidth),
          // 메뉴 목록
          // TODO : 실제 아카데미 관련 기능 구현 후 연결
          // MenuContainer(
          //   iconImage: Image.asset(
          //       "assets/icons/category/admin/point.png",
          //       fit: BoxFit.contain,
          //       filterQuality: FilterQuality.high
          //   ),
          //   menuName: "포인트 관리",
          //   callbackUrl: "/point",
          // ),
        ]
    );
  }
}