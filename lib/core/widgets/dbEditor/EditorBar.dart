
import 'package:constellation_cafe/data/model/dbEditor/DBController.dart';
import 'editTool/AddButton.dart';
import 'editTool/SaveButton.dart';
import 'editTool/DeleteButton.dart';
import 'editTool/EditButton.dart';
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