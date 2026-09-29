import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_size.dart';
import 'package:constellation_cafe/shared/constants/db_editor_strings.dart';
import 'package:constellation_cafe/shared/constants/db_editor_tokens.dart';
import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';
import 'package:constellation_cafe/shared/notifier/db_editor/db_editor_notifier.dart';
import 'package:constellation_cafe/shared/widgets/snack_bar/save_result_bar.dart';

import '../../loading/button_loading.dart';
import 'db_tool_button_style.dart';

class SaveButton extends ConsumerStatefulWidget {
  final RepositoryInterface repository;

  const SaveButton({super.key, required this.repository});

  @override
  ConsumerState<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends ConsumerState<SaveButton> {
  bool _isSaving = false;

  Future<void> _onPressed() async {
    setState(() => _isSaving = true);

    try {
      final messages = await ref
          .read(dbEditorProvider(widget.repository).notifier)
          .save();

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
        SaveResultBar.build(
          context,
          DbEditorStrings.saveError(DbEditorStrings.errorMessage(e)),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ConstSize.largeSpacing,
      child: ElevatedButton(
        onPressed: _isSaving ? null : _onPressed,
        style: dbToolButtonStyle,
        child: _isSaving
            ? const SizedBox(
                width: DbEditorTokens.toolButtonLoadingSize,
                height: DbEditorTokens.toolButtonLoadingSize,
                child: ButtonLoading(),
              )
            : const Text(DbEditorStrings.save),
      ),
    );
  }
}
