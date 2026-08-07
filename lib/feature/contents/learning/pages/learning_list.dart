
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/di/RepositoryProvider.dart';
import 'package:constellation_cafe/shared/widgets/db_editor/DBEditor.dart';
import 'package:constellation_cafe/feature/auth/notifier/login_check_notifier.dart';

class LearningList extends ConsumerWidget {
  const LearningList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final login = ref.watch(loginCheckProvider);
    final learningRepository = ref.read(learningRepositoryProvider);

    return login.when(
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
        data: (isLoggedIn) {
          if (!isLoggedIn) return const SizedBox.shrink();
          return Center(
              child: DBEditor(repository: learningRepository)
          );
        }
    );
  }
}