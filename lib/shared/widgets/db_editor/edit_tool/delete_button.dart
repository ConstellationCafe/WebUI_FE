import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/shared/constants/db_editor_strings.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';
import 'package:constellation_cafe/shared/notifier/db_editor/db_editor_notifier.dart';

import 'db_tool_button_style.dart';

class DeleteButton extends ConsumerWidget {
  final RepositoryInterface repository;

  const DeleteButton({super.key, required this.repository});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: ConstSize.largeSpacing,
      child: ElevatedButton(
        onPressed: () =>
            ref.read(dbEditorProvider(repository).notifier).deleteRow(),
        style: dbToolButtonStyle,
        child: const Text(DbEditorStrings.delete),
      ),
    );
  }
}
