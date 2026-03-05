import 'package:flutter/material.dart';

import 'package:constellation_cafe/data/model/dbEditor/DBController.dart';

class EditButton extends StatelessWidget {
  final DBController controller;

  const EditButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => controller.toggleEditMode(),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 30),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text("수정"),
    );
  }
}