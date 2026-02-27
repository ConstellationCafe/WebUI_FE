
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Routes/LoginCheckProvider.dart';
import '../../../../core/di/RepositoryProvider.dart';
import '../../../../core/widgets/dbEditor/DBEditor.dart';

class MusicList extends ConsumerWidget {
  const MusicList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final login = ref.watch(loginCheckProvider);
    final musicRepository = ref.read(musicRepositoryProvider);

    return login.when(
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
        data: (isLoggedIn) {
          if (!isLoggedIn) return const SizedBox.shrink();
          return Center(
              child: DBEditor(repository: musicRepository)
          );
        }
    );
  }
}