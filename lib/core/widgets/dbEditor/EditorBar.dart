
import 'package:constellation_cafe/data/model/dbEditor/DBController.dart';
import 'EditTool/AddButton.dart';
import 'EditTool/SaveButton.dart';
import 'EditTool/DeleteButton.dart';
import 'EditTool/EditButton.dart';
import 'package:flutter/material.dart';


class EditorBar extends StatelessWidget {
  final DBController controller;

  const EditorBar({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,        // 가로 간격
      runSpacing: 8,     // 세로 간격 (줄 바뀔 때)
      children: [
        AddButton(controller: controller),
        EditButton(controller: controller),
        DeleteButton(controller: controller),
        SaveButton(controller: controller),
      ],
    );
  }
}