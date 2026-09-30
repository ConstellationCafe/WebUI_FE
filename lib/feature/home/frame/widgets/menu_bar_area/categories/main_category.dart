import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/modules/academy/category/academy_category.dart';
import 'package:constellation_cafe/feature/modules/academy/notifier/permission_notifier/academy_permission_notifier.dart';
import 'package:constellation_cafe/feature/modules/chatbot/category/chatbot_category.dart';
import 'package:constellation_cafe/feature/modules/competition/category/competition_category.dart';
import 'package:constellation_cafe/feature/modules/competition/notifier/competition_permission_notifier.dart';
import 'package:constellation_cafe/feature/modules/erp/category/erp_category.dart';
import 'package:constellation_cafe/feature/modules/shadowverse/category/shadowverse_category.dart';
import 'package:constellation_cafe/shared/domain/user/user_role.dart';

class MainCategory extends ConsumerStatefulWidget {
  const MainCategory({super.key});

  @override
  ConsumerState<MainCategory> createState() => _MainCategoryState();
}

class _MainCategoryState extends ConsumerState<MainCategory> {
  @override
  Widget build(BuildContext build) {
    final globalState = ref.watch(currentUserStateProvider);
    final permissionState = ref.watch(academyPermissionProvider);
    final competitionPermission = ref.watch(competitionPermissionProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ChatBotCategory(),
        ShadowverseCategory(),
        if (!permissionState.isLoading && permissionState.isInitialized) ...[
          AcademyCategory(),
        ],
        // 대회 매니저 역할(또는 서버장)이 있으면 보인다. 최종 판단은 서버가 한다.
        if (competitionPermission.isManager) CompetitionCategory(),
        if (globalState.roles.contains(UserRole.admin)) ...[ErpCategory()],
      ],
    );
  }
}
