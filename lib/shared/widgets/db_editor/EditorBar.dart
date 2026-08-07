
import 'package:constellation_cafe/shared/model/db_editor/DBController.dart';
import 'edit_tool/AddButton.dart';
import 'edit_tool/SaveButton.dart';
import 'edit_tool/DeleteButton.dart';
import 'edit_tool/EditButton.dart';
import 'package:flutter/material.dart';


class EditorBar extends StatelessWidget {
  final DBController controller;

  final GlobalKey? addKey;
  final GlobalKey? deleteKey;
  final GlobalKey? editKey;
  final GlobalKey? saveKey;

  const EditorBar({
    super.key,
    required this.controller,
    this.addKey,
    this.deleteKey,
    this.editKey,
    this.saveKey,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,        // 가로 간격
      runSpacing: 8,     // 세로 간격 (줄 바뀔 때)
      children: [
        AddButton(
            key: addKey,
            controller: controller
        ),
        EditButton(
            key: deleteKey,
            controller: controller
        ),
        DeleteButton(
            key: editKey,
            controller: controller
        ),
        SaveButton(
            key: saveKey,
            controller: controller
        ),
      ],
    );
  }
}