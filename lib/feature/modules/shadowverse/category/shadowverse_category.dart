import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';

class ShadowverseCategory extends ConsumerWidget {
  const ShadowverseCategory({super.key});

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "섀도우버스 메뉴",
            textAlign: TextAlign.left,
          ),
          SizedBox(height: ConstSize.smallSpacing),
          MenuContainer(
            iconImage: Image.asset(
              "assets/icons/modules/shadowverse/friendly_match.png",
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
            menuName: "친선전",
            callbackUrl: "/friendly_match",
          ),
          SizedBox(height: ConstSize.smallSpacing),
        ]
    );
  }
}