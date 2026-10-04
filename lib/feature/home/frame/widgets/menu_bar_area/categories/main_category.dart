import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/home/constants/home_strings.dart';
import 'package:constellation_cafe/feature/module_config/notifier/module_config_notifier.dart';
import 'package:constellation_cafe/feature/modules/academy/category/academy_category.dart';
import 'package:constellation_cafe/feature/modules/chatbot/category/chatbot_category.dart';
import 'package:constellation_cafe/feature/modules/competition/category/competition_category.dart';
import 'package:constellation_cafe/feature/modules/erp/category/erp_category.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/category/shadowverse_category.dart';

/// 메뉴 바의 카테고리 목록.
///
/// 여기서는 채팅방 ModuleConfig로 활성화된 모듈인지만 본다. 권한에 맞는 기능이
/// 하나라도 있는지는 각 카테고리가 판단해, 보여줄 기능이 없으면 카테고리째 숨긴다.
/// 기능별 권한 조건이 카테고리 안에 있으므로 메뉴를 추가할 때 두 곳을 맞출 필요가 없다.
/// ERP는 ModuleConfig 대상 모듈이 아니므로 권한만으로 표시한다.
class MainCategory extends ConsumerWidget {
  const MainCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moduleState = ref.watch(moduleConfigProvider);
    final modules = moduleState.value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 로딩
        if (moduleState.isLoading)
          Padding(
            padding: const EdgeInsets.all(ConstSize.mediumSpacing),
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
              semanticsLabel: HomeStrings.loadingModules,
            ),
          ),
        // 오류
        if (moduleState.hasError) ...[
          const Text(HomeStrings.modulesLoadFailed),
          ElevatedButton(
            onPressed: () => ref.read(moduleConfigProvider.notifier).load(),
            child: const Text(HomeStrings.retryModules),
          ),
        ],
        // ModuleConfig로 활성화된 모듈만 적재하고, 권한별 기능 노출은 각 카테고리가 정한다.
        if (modules?.isEmpty == true) const Text(HomeStrings.noModules),
        if (modules?.chatbot == true) const ChatBotCategory(),
        if (modules?.shadowverse == true) const ShadowverseCategory(),
        if (modules?.academy == true) const AcademyCategory(),
        if (modules?.competition == true) const CompetitionCategory(),
        const ErpCategory(),
      ],
    );
  }
}
