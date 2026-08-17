import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../notifier/academy_notifier.dart';
import '../../state/academy_form_state.dart';
import 'academy_date_field.dart';
import '../academy_section_card.dart';
import 'academy_selection_fields.dart';
import 'academy_time_range_field.dart';

class AcademyBasicInfo extends ConsumerWidget {
  final AcademyFormState state;

  const AcademyBasicInfo({
    super.key,
    required this.state,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final notifier = ref.read(academyProvider.notifier);

    return AcademySectionCard(
      title: '기본 정보',
      icon: Icons.menu_book_rounded,
      child: Column(
        children: [
          AcademySelectionFields(
            state: state,
            onAcademyChanged: notifier.selectAcademy,
            onClassChanged: notifier.selectClass,
            onSubjectChanged: notifier.selectSubject,
          ),
          const SizedBox(
            height: ConstPadding.mediumPadding,
          ),
          Row(
            children: [
              Expanded(
                child: AcademyDateField(
                  date: state.educationDate,
                  onChanged: notifier.setEducationDate,
                ),
              ),
              const SizedBox(
                width: ConstPadding.mediumPadding,
              ),
              Expanded(
                child: AcademyTimeRangeField(
                  startTime: state.startTime,
                  endTime: state.endTime,
                  onStartTimeChanged: notifier.setStartTime,
                  onEndTimeChanged: notifier.setEndTime,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}