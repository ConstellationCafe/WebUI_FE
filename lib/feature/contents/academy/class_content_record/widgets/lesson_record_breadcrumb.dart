import 'package:flutter/material.dart';

import '../../constants/academy_constants.dart';

class LessonRecordBreadcrumb extends StatelessWidget {
  const LessonRecordBreadcrumb({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(
          '수업 관리',
          style: textTheme.bodySmall,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
            AcademyConstants.breadcrumbIconHorizontalPadding,
          ),
          child: Icon(
            Icons.chevron_right,
            size: AcademyConstants.breadcrumbIconSize,
          ),
        ),
        Text(
          '수업 내용 기록',
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}