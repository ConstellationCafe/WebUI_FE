import 'package:flutter/material.dart';

import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';

import '../../constants/db_editor_tokens.dart';
import 'edit_tool/add_button.dart';
import 'edit_tool/delete_button.dart';
import 'edit_tool/edit_button.dart';
import 'edit_tool/save_button.dart';

/// 행 추가·수정·삭제·저장 도구.
class EditorBar extends StatelessWidget {
  final RepositoryInterface repository;

  final GlobalKey? addKey;
  final GlobalKey? deleteKey;
  final GlobalKey? editKey;
  final GlobalKey? saveKey;

  const EditorBar({
    super.key,
    required this.repository,
    this.addKey,
    this.deleteKey,
    this.editKey,
    this.saveKey,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: DbEditorTokens.toolbarSpacing,
      runSpacing: DbEditorTokens.toolbarSpacing,
      children: [
        AddButton(key: addKey, repository: repository),
        EditButton(key: deleteKey, repository: repository),
        DeleteButton(key: editKey, repository: repository),
        SaveButton(key: saveKey, repository: repository),
      ],
    );
  }
}
