import 'package:flutter/material.dart';

import 'package:constellation_cafe/data/model/dbEditor/DBController.dart';

class AddButton extends StatelessWidget {
  final DBController controller;

  const AddButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: () {
          controller.addRow();
        },
        child: const Text("추가"),
      )
    );
  }
}