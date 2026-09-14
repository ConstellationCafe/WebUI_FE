import 'package:flutter/material.dart';

import '../../../../../core/constants/const_padding.dart';


class LessonRecordHeader extends StatelessWidget {
  const LessonRecordHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '수업 내용 조회',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(
          height: ConstPadding.tinyPadding,
        ),
        Text(
          '기록한 수업 내용을 조회할 수 있습니다.',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}