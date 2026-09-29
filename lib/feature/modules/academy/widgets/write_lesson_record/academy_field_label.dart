import 'package:flutter/material.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';

/// 수업 기록 입력 항목의 제목. 필수 항목이면 뒤에 표시를 붙인다.
class AcademyFieldLabel extends StatelessWidget {
  final String text;
  final bool isRequired;

  const AcademyFieldLabel(this.text, {super.key, this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelLarge,
        children: [
          TextSpan(text: text),
          if (isRequired)
            const TextSpan(
              text: AcademyStrings.requiredMark,
              style: TextStyle(color: AcademyConstants.requiredMarkColor),
            ),
        ],
      ),
    );
  }
}
