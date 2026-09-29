import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import 'package:constellation_cafe/shared/widgets/loading/button_loading.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';

class StatusActions extends StatelessWidget {
  final bool isProcessing;

  final VoidCallback onCancel;
  final VoidCallback onProcess;

  const StatusActions({
    super.key,
    required this.isProcessing,
    required this.onCancel,
    required this.onProcess,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: isProcessing ? null : onCancel,
          child: const Text(AcademyStrings.cancel),
        ),

        const SizedBox(width: ConstPadding.smallPadding),

        ElevatedButton.icon(
          onPressed: isProcessing ? null : onProcess,
          icon: isProcessing
              ? const SizedBox(
                  width: AcademyConstants.savingIndicatorSize,
                  height: AcademyConstants.savingIndicatorSize,
                  child: ButtonLoading(),
                )
              : const Icon(Icons.check),
          label: Text(
            isProcessing ? AcademyStrings.processing : AcademyStrings.process,
          ),
        ),
      ],
    );
  }
}
