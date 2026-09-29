import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/modules/chatbot/menu/data/repository/menu_repository.dart';
import 'package:constellation_cafe/shared/domain/user/user_role.dart';
import 'package:constellation_cafe/shared/widgets/db_editor/db_editor.dart';

class MenuList extends ConsumerWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuRepository = ref.watch(menuRepositoryProvider);
    final isAdmin = ref.watch(
      currentUserStateProvider.select(
        (state) => state.roles.contains(UserRole.admin),
      ),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: DBEditor(
                repository: menuRepository,
                hiddenColumns: isAdmin ? const {} : const {'discordId'},
              ),
            ),
          ),
        );
      },
    );
  }
}
