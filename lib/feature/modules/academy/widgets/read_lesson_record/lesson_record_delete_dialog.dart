import 'package:flutter/material.dart';

import '../../constants/academy_strings.dart';

/// 수업 기록 삭제 확인. 삭제하면 true, 취소하면 false로 닫힌다.
class LessonRecordDeleteDialog extends StatelessWidget {
  const LessonRecordDeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AcademyStrings.deleteLessonRecord),
      content: const Text(AcademyStrings.deleteLessonRecordConfirm),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(AcademyStrings.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(AcademyStrings.delete),
        ),
      ],
    );
  }
}
