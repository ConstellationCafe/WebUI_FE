import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/modules/chatbot/content/data/repository/content_repository.dart';
import 'package:constellation_cafe/shared/domain/user/user_role.dart';
import 'package:constellation_cafe/shared/widgets/db_editor/db_editor.dart';

class ContentList extends ConsumerWidget {
  const ContentList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentRepository = ref.watch(contentRepositoryProvider);
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
                repository: contentRepository,
                hiddenColumns: isAdmin ? const {} : const {'discordId'},
              ),
            ),
          ),
        );
      },
    );
  }
}
