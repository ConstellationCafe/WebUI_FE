import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/shared/widgets/loading/button_loading.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';

class LessonRecordBottom extends StatelessWidget {
  final bool isSaving;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const LessonRecordBottom({
    super.key,
    required this.isSaving,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: isSaving ? null : onCancel,
            child: const Text(AcademyStrings.cancel),
          ),
          const SizedBox(width: ConstPadding.smallPadding),
          ElevatedButton.icon(
            onPressed: isSaving ? null : onSave,
            icon: isSaving
                ? const SizedBox(
                    width: AcademyConstants.savingIndicatorSize,
                    height: AcademyConstants.savingIndicatorSize,
                    child: ButtonLoading(),
                  )
                : const Icon(Icons.save_outlined),
            label: Text(isSaving ? AcademyStrings.saving : AcademyStrings.save),
          ),
        ],
      ),
    );
  }
}
