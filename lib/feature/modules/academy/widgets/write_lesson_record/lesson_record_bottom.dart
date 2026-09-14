import 'package:constellation_cafe/shared/widgets/loading/ButtonLoading.dart';
import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';

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
            child: const Text('취소'),
          ),
          const SizedBox(
            width: ConstPadding.smallPadding,
          ),
          ElevatedButton.icon(
            onPressed: isSaving ? null : onSave,
            icon: isSaving
                ? const SizedBox(
                    width: AcademyConstants.savingIndicatorSize,
                    height: AcademyConstants.savingIndicatorSize,
                    child: ButtonLoading(),
                  )
                : const Icon(Icons.save_outlined),
            label: Text(
              isSaving ? '저장 중...' : '저장하기',
            ),
          ),
        ],
      ),
    );
  }
}