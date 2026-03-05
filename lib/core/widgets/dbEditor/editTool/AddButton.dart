import 'package:flutter/material.dart';

import 'package:constellation_cafe/data/model/dbEditor/DBController.dart';

class AddButton extends StatelessWidget {
  final DBController controller;

  const AddButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: controller.addRow,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 30), // 높이 30 보장
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text("추가"),
    );
  }
}