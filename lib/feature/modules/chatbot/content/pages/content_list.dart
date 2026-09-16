
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/di/RepositoryProvider.dart';
import 'package:constellation_cafe/shared/widgets/db_editor/DBEditor.dart';

import 'package:constellation_cafe/shared/domain/user/user_role.dart';
import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';

class ContentList extends ConsumerWidget {
  const ContentList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentRepository = ref.read(contentRepositoryProvider);
    final isAdmin = ref.watch(
      currentUserStateProvider.select(
            (state) => state.roles.contains(UserRole.ADMIN),
      ),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Center(
              child: DBEditor(
                repository: contentRepository,
                hiddenColumns: isAdmin
                    ? const {}
                    : const {'recommender'},
                readOnlyColumns: isAdmin
                    ? const {'recommender'}
                    : const {}
              ),
            ),
          ),
        );
      },
    );
  }
}
