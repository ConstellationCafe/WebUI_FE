
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/RepositoryProvider.dart';
import '../../../../core/widgets/dbEditor/DBEditor.dart';
import '../../../../routes/login_check_notifier.dart';

class ViewPointLog extends ConsumerWidget {
  const ViewPointLog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final login = ref.watch(loginCheckProvider);
    final pointRepository = ref.read(pointRepositoryProvider);

    return login.when(
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
        data: (isLoggedIn) {
          if (!isLoggedIn) return const SizedBox.shrink();
          return Center(
              child: DBEditor(
                  repository: pointRepository,
                  readonly: true
              )
          );
        }
    );
  }
}