import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';

/// 조회 조건에 맞는 수업 기록이 없을 때의 안내.
class LessonRecordEmptyView extends StatelessWidget {
  const LessonRecordEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ConstPadding.largePaddingAll,
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.menu_book_outlined,
              size: AcademyConstants.emptyIconSize,
            ),
            const SizedBox(height: ConstPadding.smallPadding),
            Text(
              AcademyStrings.noLessonRecords,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
