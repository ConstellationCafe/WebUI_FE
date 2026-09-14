
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/di/RepositoryProvider.dart';
import 'package:constellation_cafe/shared/widgets/db_editor/DBEditor.dart';

class MusicList extends ConsumerWidget {
  const MusicList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicRepository = ref.read(musicRepositoryProvider);
    return SingleChildScrollView(
      child: Center(
        child: DBEditor(
          repository: musicRepository,
        ),
      ),
    );
  }
}