import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import '../../../notifier/academy_notifier/lesson_record_notifier.dart';
import '../../../state/lesson_record_form_state/lesson_record_form_state.dart';
import '../academy_section_card.dart';
import 'co_teacher_field.dart';
import 'main_teacher_field.dart';

class AcademyTeacherInfo extends ConsumerWidget {
  final AcademyFormState state;

  const AcademyTeacherInfo({
    super.key,
    required this.state,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final notifier =
    ref.read(academyProvider.notifier);

    return AcademySectionCard(
      title: '교사 정보',
      icon: Icons.person_outline_rounded,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: MainTeacherField(
                teachers: state.teachers,
                selectedTeacher: state.mainTeacher,
                onChanged: notifier.selectMainTeacher,
              ),
            ),
            const SizedBox(
              width: ConstPadding.mediumPadding,
            ),
            Expanded(
              child: CoTeacherField(
                teachers: state.teachers,
                mainTeacher: state.mainTeacher,
                selectedCoTeachers: state.selectedCoTeachers,
                onChanged: notifier.toggleCoTeacher,
              ),
            ),
          ],
        ),
      ),
    );
  }
}