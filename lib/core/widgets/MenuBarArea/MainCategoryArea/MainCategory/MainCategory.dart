import 'package:constellation_cafe/core/widgets/MenuBarArea/MainCategoryArea/MainCategory/Category/AdminCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/UserRole.dart';
import '../../../../state/Notifier/global_state_notifier.dart';
import 'Category/UserCategory.dart';

class MainCategory extends ConsumerStatefulWidget {
  const MainCategory({super.key});

  @override
  ConsumerState<MainCategory> createState() => _MainCategoryState();
}

class _MainCategoryState extends ConsumerState<MainCategory> {
  @override
  Widget build(BuildContext build) {
    final globalState = ref.read(globalStateProvider);
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
