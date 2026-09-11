import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/shared/domain/user/user_role.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import '../../../../../auth/category/user_category.dart';
import '../../../../../auth/category/admin_category.dart';
import '../../../../../contents/academy/category/academy_category.dart';
import '../../../../../contents/academy/notifier/permission_notifier/academy_permission_notifier.dart';


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
          UserCategory(),
          if (globalState.roles.contains(UserRole.ADMIN)) ... [
            AdminCategory(),
          ],
          if (!permissionState.isLoading && permissionState.isInitialized) ... [
            AcademyCategory()
          ],
        ]
    );
  }
}
