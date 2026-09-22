import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          iconImage: Image.asset(
            "assets/icons/modules/chatbot/learning.png",
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
          menuName: "가르치기",
          callbackUrl: "/learning",
        ),
        SizedBox(height: ConstSize.smallSpacing),
        MenuContainer(
          iconImage: Image.asset(
            "assets/icons/modules/chatbot/recommend_menu.png",
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
          menuName: "메뉴추천",
          callbackUrl: "/menu",
        ),
        SizedBox(height: ConstSize.smallSpacing),
        MenuContainer(
          iconImage: Image.asset(
            "assets/icons/modules/chatbot/recommend_music.png",
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
          menuName: "노래추천",
          callbackUrl: "/music",
        ),
        SizedBox(height: ConstSize.smallSpacing),
        MenuContainer(
          iconImage: Image.asset(
            "assets/icons/modules/chatbot/recommend_content.png",
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
          menuName: "놀이추천",
          callbackUrl: "/content",
        ),
        SizedBox(height: ConstSize.smallSpacing),
      ],
    );
  }
}
