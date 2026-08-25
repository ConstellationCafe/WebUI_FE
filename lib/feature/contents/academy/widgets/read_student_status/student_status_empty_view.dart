import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';

class StudentStatusEmptyView extends StatelessWidget {
  const StudentStatusEmptyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: ConstPadding.largePaddingAll,
        child: Column(
          children: [
            Icon(
              Icons.person_search_outlined,
              size: AcademyConstants.emptyIconSize,
              color: Theme.of(context)
                  .colorScheme
                  .outline,
            ),
            const SizedBox(
              height: ConstPadding.mediumPadding,
            ),
            Text(
              '조회된 학생이 없습니다.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}