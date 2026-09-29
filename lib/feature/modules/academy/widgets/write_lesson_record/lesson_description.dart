import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';
import '../../notifier/lesson_record_form_notifier/lesson_record_form_notifier.dart';
import 'academy_section_card.dart';

class LessonDescription extends ConsumerWidget {
  final String description;

  const LessonDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(lessonRecordFormProvider.notifier);

    return AcademySectionCard(
      title: AcademyStrings.lessonDescription,
      icon: Icons.description_outlined,
      child: TextFormField(
        initialValue: description,
        maxLines: AcademyConstants.lessonDescriptionLines,
        maxLength: AcademyConstants.lessonDescriptionMaxLength,
        onChanged: notifier.setDescription,
        decoration: const InputDecoration(
          hintText: AcademyStrings.lessonDescriptionHint,
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
