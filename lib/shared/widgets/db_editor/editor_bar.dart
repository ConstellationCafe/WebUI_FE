import 'package:constellation_cafe/shared/controller/db_editor/db_controller.dart';
import 'edit_tool/add_button.dart';
import 'edit_tool/save_button.dart';
import 'edit_tool/delete_button.dart';
import 'edit_tool/edit_button.dart';
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
      spacing: 8, // 가로 간격
      runSpacing: 8, // 세로 간격 (줄 바뀔 때)
      children: [
        AddButton(key: addKey, controller: controller),
        EditButton(key: deleteKey, controller: controller),
        DeleteButton(key: editKey, controller: controller),
        SaveButton(key: saveKey, controller: controller),
      ],
    );
  }
}
