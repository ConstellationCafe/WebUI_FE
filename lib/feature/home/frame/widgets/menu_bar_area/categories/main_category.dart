import 'package:constellation_cafe/feature/modules/chatbot/category/chatbot_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/shared/domain/user/user_role.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import '../../../../../modules/erp/category/erp_category.dart';
import '../../../../../modules/shadowverse/category/shadowverse_category.dart';
import '../../../../../modules/academy/category/academy_category.dart';
import '../../../../../modules/academy/notifier/permission_notifier/academy_permission_notifier.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ChatBotCategory(),
        ShadowverseCategory(),
        if (!permissionState.isLoading && permissionState.isInitialized) ...[
          AcademyCategory(),
        ],
        if (globalState.roles.contains(UserRole.ADMIN)) ...[
          ErpCategory()
        ],
      ],
    );
  }
}
