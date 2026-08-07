import 'package:constellation_cafe/shared/widgets/MenuBarArea/MainCategoryArea/MainCategory/Category/AdminCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/shared/domain/user/user_role.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'Category/UserCategory.dart';

class MainCategory extends ConsumerStatefulWidget {
  const MainCategory({super.key});

  @override
  ConsumerState<MainCategory> createState() => _MainCategoryState();
}

class _MainCategoryState extends ConsumerState<MainCategory> {
  @override
  Widget build(BuildContext build) {
    final globalState = ref.read(currentUserStateProvider);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          UserCategory(),
          if (globalState.roles.contains(UserRole.ADMIN)) ... [
            AdminCategory()
          ]
        ]
    );
  }
}
