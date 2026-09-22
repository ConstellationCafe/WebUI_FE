import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';

class ChatBotCategory extends ConsumerWidget {
  const ChatBotCategory({super.key});

  @override
  Widget build(BuildContext build, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("빗자루 메뉴", textAlign: TextAlign.left),
        SizedBox(height: ConstSize.smallSpacing),
        MenuContainer(
          iconImage: SvgPicture.asset(
            "assets/icons/modules/chatbot/learning.svg",
            fit: BoxFit.contain,
          ),
          menuName: "가르치기",
          callbackUrl: "/learning",
        ),
        SizedBox(height: ConstSize.smallSpacing),
        MenuContainer(
          iconImage: SvgPicture.asset(
            "assets/icons/modules/chatbot/recommend_menu.svg",
            fit: BoxFit.contain,
          ),
          menuName: "메뉴추천",
          callbackUrl: "/menu",
        ),
        SizedBox(height: ConstSize.smallSpacing),
        MenuContainer(
          iconImage: SvgPicture.asset(
            "assets/icons/modules/chatbot/recommend_music.svg",
            fit: BoxFit.contain,
          ),
          menuName: "노래추천",
          callbackUrl: "/music",
        ),
        SizedBox(height: ConstSize.smallSpacing),
        MenuContainer(
          iconImage: SvgPicture.asset(
            "assets/icons/modules/chatbot/recommend_content.svg",
            fit: BoxFit.contain,
          ),
          menuName: "놀이추천",
          callbackUrl: "/content",
        ),
        SizedBox(height: ConstSize.smallSpacing),
      ],
    );
  }
}
