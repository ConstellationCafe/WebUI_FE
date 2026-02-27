import 'package:flutter/material.dart';

import 'package:constellation_cafe/data/model/dbEditor/DBController.dart';

class DeleteButton extends StatelessWidget {
  final DBController controller;

  const DeleteButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        child: ElevatedButton(
          onPressed: () {
            controller.deleteRow();
          },
          child: const Text("삭제"),
        )
    );
  }
}