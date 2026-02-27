
import 'package:constellation_cafe/core/widgets/snackBar/SaveResultBar.dart';
import 'package:flutter/material.dart';

import 'package:constellation_cafe/data/model/dbEditor/DBController.dart';

import '../../loading/ButtonLoading.dart';

class SaveButton extends StatefulWidget {
  final DBController controller;

  const SaveButton({
    super.key,
    required this.controller,
  });

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool _isLoading = false;

  Future<void> _onPressed() async {
    setState(() => _isLoading = true);

    try {
      final messages = await widget.controller.save();

      if (!mounted) return;

      await SaveResultBar.showAll(
        context,
        messages,
        type: SaveResultType.success,
        durationPerBar: const Duration(seconds: 2),
        clearBefore: true,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SaveResultBar.build(context, "저장 실패 : $e")
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        child: ElevatedButton(
          onPressed: _isLoading ? null : _onPressed,
          child: _isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: ButtonLoading(),
                )
              : const Text("저장"),
        )
    );
  }
}
