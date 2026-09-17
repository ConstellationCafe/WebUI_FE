import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/di/RepositoryProvider.dart';
import 'package:constellation_cafe/shared/widgets/db_editor/DBEditor.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/shared/domain/user/user_role.dart';

class LearningList extends ConsumerWidget {
  const LearningList({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final learningRepository =
    ref.read(
      learningRepositoryProvider,
    );

    final isAdmin = ref.watch(
      currentUserStateProvider.select(
            (state) =>
            state.roles.contains(
              UserRole.ADMIN,
            ),
      ),
    );

    return LayoutBuilder(
      builder: (
          context,
          constraints,
          ) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
              constraints.maxHeight,
            ),
            child: Center(
              child: DBEditor(
                repository:
                learningRepository,
                hiddenColumns: isAdmin
                    ? const {}
                    : const {'discordId'},
              ),
            ),
          ),
        );
      },
    );
  }
}