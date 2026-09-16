
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/di/RepositoryProvider.dart';
import 'package:constellation_cafe/shared/widgets/db_editor/DBEditor.dart';

class ViewPointLog extends ConsumerWidget {
  const ViewPointLog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointRepository = ref.read(pointRepositoryProvider);
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Center(
              child: DBEditor(
                  repository: pointRepository,
                  readonly: true
              ),
            ),
          ),
        );
      },
    );
  }
}