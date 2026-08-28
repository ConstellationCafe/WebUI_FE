
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/di/RepositoryProvider.dart';
import 'package:constellation_cafe/shared/widgets/db_editor/DBEditor.dart';

class ContentList extends ConsumerWidget {
  const ContentList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentRepository = ref.read(contentRepositoryProvider);
    return SingleChildScrollView(
      child: Center(
          child: DBEditor(repository: contentRepository)
      )
    );
  }
}
