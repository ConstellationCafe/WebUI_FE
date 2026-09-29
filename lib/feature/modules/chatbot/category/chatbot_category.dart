import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_category_section.dart';
import 'package:constellation_cafe/feature/home/frame/widgets/menu_bar_area/categories/container/menu_container.dart';

import '../constants/chatbot_assets.dart';
import '../constants/chatbot_strings.dart';

class ChatBotCategory extends ConsumerWidget {
  const ChatBotCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuCategorySection(
      title: ChatBotStrings.menuTitle,
      storageKey: 'chatbot',
      children: [
        MenuContainer(
          iconImage: SvgPicture.asset(
            ChatBotAssets.learning,
            fit: BoxFit.contain,
          ),
          menuName: ChatBotStrings.learningMenu,
          callbackUrl: '/learning',
        ),
        const SizedBox(height: ConstSize.smallSpacing),
        MenuContainer(
          iconImage: SvgPicture.asset(
            ChatBotAssets.recommendMenu,
            fit: BoxFit.contain,
          ),
          menuName: ChatBotStrings.recommendMenu,
          callbackUrl: '/menu',
        ),
        const SizedBox(height: ConstSize.smallSpacing),
        MenuContainer(
          iconImage: SvgPicture.asset(
            ChatBotAssets.recommendMusic,
            fit: BoxFit.contain,
          ),
          menuName: ChatBotStrings.recommendMusic,
          callbackUrl: '/music',
        ),
        const SizedBox(height: ConstSize.smallSpacing),
        MenuContainer(
          iconImage: SvgPicture.asset(
            ChatBotAssets.recommendContent,
            fit: BoxFit.contain,
          ),
          menuName: ChatBotStrings.recommendContent,
          callbackUrl: '/content',
        ),
        const SizedBox(height: ConstSize.smallSpacing),
      ],
    );
  }
}
