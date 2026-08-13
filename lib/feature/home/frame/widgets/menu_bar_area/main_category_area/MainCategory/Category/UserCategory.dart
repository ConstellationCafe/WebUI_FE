import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Container/MenuContainer.dart';

class UserCategory extends ConsumerWidget {
  const UserCategory({super.key});

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "사용자 메뉴",
            textAlign: TextAlign.left,
            style: Theme.of(build).textTheme.titleMedium,
          ),
          SizedBox(height: ConstSize.smallSpacing),
          MenuContainer(
            iconImage: Image.asset(
              "assets/icons/category/user/friendly_match.png",
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
            menuName: "친선전",
            callbackUrl: "/friendly_match",
          ),
          SizedBox(height: ConstSize.smallSpacing),
          MenuContainer(
            iconImage: Image.asset(
              "assets/icons/category/user/learning.png",
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
            menuName: "가르치기",
            callbackUrl: "/learning",
          ),
          SizedBox(height: ConstSize.smallSpacing),
          MenuContainer(
            iconImage: Image.asset(
              "assets/icons/category/user/recommend_menu.png",
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,),
            menuName: "메뉴추천",
            callbackUrl: "/menu",
          ),
          SizedBox(height: ConstSize.smallSpacing),
          MenuContainer(
            iconImage: Image.asset(
              "assets/icons/category/user/recommend_music.png",
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,),
            menuName: "노래추천",
            callbackUrl: "/music",
          ),
          SizedBox(height: ConstSize.smallSpacing),
          MenuContainer(
            iconImage: Image.asset(
              "assets/icons/category/user/recommend_content.png",
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,),
            menuName: "놀이추천",
            callbackUrl: "/content",
          ),
          SizedBox(height: ConstSize.smallSpacing),
        ]
    );
  }
}