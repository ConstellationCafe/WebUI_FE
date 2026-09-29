import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_strings.dart';

class LessonRecordHeader extends StatelessWidget {
  final bool isDesktop;

  const LessonRecordHeader({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AcademyStrings.writeLessonRecordTitle,
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: ConstPadding.tinyPadding),
        Text(
          AcademyStrings.writeLessonRecordDescription,
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
