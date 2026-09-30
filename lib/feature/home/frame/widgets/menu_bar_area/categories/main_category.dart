import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/feature/home/constants/home_strings.dart';
import 'package:constellation_cafe/feature/module_config/notifier/module_config_notifier.dart';
import 'package:constellation_cafe/feature/modules/academy/category/academy_category.dart';
import 'package:constellation_cafe/feature/modules/academy/notifier/permission_notifier/academy_permission_notifier.dart';
import 'package:constellation_cafe/feature/modules/chatbot/category/chatbot_category.dart';
import 'package:constellation_cafe/feature/modules/competition/category/competition_category.dart';
import 'package:constellation_cafe/feature/modules/competition/notifier/competition_permission_notifier.dart';
import 'package:constellation_cafe/feature/modules/erp/category/erp_category.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/category/shadowverse_category.dart';
import 'package:constellation_cafe/shared/domain/user/user_role.dart';

class MainCategory extends ConsumerWidget {
  const MainCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalState = ref.watch(currentUserStateProvider);
    final moduleState = ref.watch(moduleConfigProvider);
    final modules = moduleState.value;
    final permissionState = ref.watch(academyPermissionProvider);
    final competitionPermission = ref.watch(competitionPermissionProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (moduleState.isLoading)
          Padding(
            padding: const EdgeInsets.all(ConstSize.mediumSpacing),
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
              semanticsLabel: HomeStrings.loadingModules,
            ),
          ),
        if (moduleState.hasError) ...[
          const Text(HomeStrings.modulesLoadFailed),
          ElevatedButton(
            onPressed: () => ref.read(moduleConfigProvider.notifier).load(),
            child: const Text(HomeStrings.retryModules),
          ),
        ],
        if (modules?.isEmpty == true) const Text(HomeStrings.noModules),
        if (modules?.chatbot == true) ChatBotCategory(),
        if (modules?.shadowverse == true) ShadowverseCategory(),
        if (modules?.academy == true &&
            !permissionState.isLoading &&
            permissionState.isInitialized) ...[
          AcademyCategory(),
        ],
        // 대회 매니저 역할(또는 서버장)이 있으면 보인다. 최종 판단은 서버가 한다.
        if (modules?.competition == true &&
            !competitionPermission.isLoading &&
            competitionPermission.isManager)
          CompetitionCategory(),
        if (globalState.roles.contains(UserRole.admin)) ...[ErpCategory()],
      ],
    );
  }
}
