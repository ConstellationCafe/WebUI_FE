
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Routes/LoginCheckProvider.dart';
import '../../../../core/di/RepositoryProvider.dart';
import '../../../../core/widgets/dBEditor/DBEditor.dart';

class MenuList extends ConsumerWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final login = ref.watch(loginCheckProvider);
    final menuRepository = ref.read(menuRepositoryProvider);

    return login.when(
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
        data: (isLoggedIn) {
          if (!isLoggedIn) return const SizedBox.shrink();
          return Center(
              child: DBEditor(repository: menuRepository)
          );
        }
    );
  }
}