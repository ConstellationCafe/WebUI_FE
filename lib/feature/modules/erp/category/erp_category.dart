import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';

class ErpCategory extends ConsumerWidget {
  const ErpCategory({super.key});

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(textAlign: TextAlign.left, "ERP 메뉴"),
        SizedBox(height: ConstSize.tinyWidth),
        MenuContainer(
          iconImage: SvgPicture.asset(
            "assets/icons/modules/erp/point.svg",
            fit: BoxFit.contain,
          ),
          menuName: "포인트 관리",
          callbackUrl: "/point",
        ),
      ],
    );
  }
}
