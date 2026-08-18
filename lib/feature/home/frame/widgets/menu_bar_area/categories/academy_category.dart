import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'container/menu_container.dart';

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
          MenuContainer(
            iconImage: Image.asset(
                "assets/icons/category/admin/point.png",
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high
            ),
            menuName: "수업 기록",
            callbackUrl: "/academy/write_lesson_record",
          ),
          MenuContainer(
            iconImage: Image.asset(
                "assets/icons/category/admin/point.png",
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high
            ),
            menuName: "수업 기록 조회",
            callbackUrl: "/academy/read_lesson_record",
          ),
        ]
    );
  }
}