import 'package:flutter/material.dart';

import 'package:constellation_cafe/shared/model/db_editor/DBController.dart';
import 'package:constellation_cafe/core/constants/const_size.dart';


class DeleteButton extends StatelessWidget {
  final DBController controller;

  const DeleteButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: ConstSize.bigHeight,
        child: ElevatedButton(
          onPressed: () {
            controller.deleteRow();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(0, 30),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text("삭제"),
        )
    );
  }
}