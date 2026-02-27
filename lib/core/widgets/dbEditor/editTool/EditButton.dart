import 'package:flutter/material.dart';

import 'package:constellation_cafe/data/model/dbEditor/DBController.dart';

class EditButton extends StatelessWidget {
  final DBController controller;

  const EditButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        child: ElevatedButton(
          onPressed: () => controller.toggleEditMode(),
          child: const Text("수정"),
        )
    );
  }
}