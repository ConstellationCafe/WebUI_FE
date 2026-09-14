import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

class LessonRecordHeader extends StatelessWidget {
  final bool isDesktop;

  const LessonRecordHeader({
    super.key,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '수업 내용 기록',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(
          height: ConstPadding.tinyPadding,
        ),
        Text(
          '수업의 기본 정보를 입력하고 함께한 교사와 멤버를 선택해주세요.',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}