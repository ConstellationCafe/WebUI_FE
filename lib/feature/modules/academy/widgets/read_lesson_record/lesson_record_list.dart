import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../domain/model/lesson_record_view.dart';
import 'lesson_record_card.dart';

class LessonRecordList extends StatelessWidget {
  final List<LessonRecordView> records;

  const LessonRecordList({
    super.key,
    required this.records,
  });

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return _empty(context);
    }

    return ListView.separated(
      shrinkWrap: true,
      physics:
      const NeverScrollableScrollPhysics(),
      itemCount: records.length,
      separatorBuilder: (_, __) =>
      const SizedBox(
        height:
        AcademyConstants.recordCardSpacing,
      ),
      itemBuilder: (context, index) {
        return LessonRecordCard(
          record: records[index],
        );
      },
    );
  }

  Widget _empty(BuildContext context) {
    return Padding(
      padding: ConstPadding.largePaddingAll,
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.menu_book_outlined,
              size:
              AcademyConstants.emptyIconSize,
            ),
            const SizedBox(
              height: ConstPadding.smallPadding,
            ),
            Text(
              '조회된 수업 기록이 없습니다.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}