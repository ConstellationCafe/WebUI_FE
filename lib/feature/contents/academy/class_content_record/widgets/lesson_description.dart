import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/academy_notifier.dart';
import 'academy_section_card.dart';

class LessonDescription extends ConsumerWidget {
  final String description;

  const LessonDescription({
    super.key,
    required this.description,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final notifier =
    ref.read(academyNotifierProvider.notifier);

    return AcademySectionCard(
      title: '수업 설명',
      icon: Icons.description_outlined,
      child: TextFormField(
        initialValue: description,
        maxLines: 7,
        maxLength: 1000,
        onChanged: notifier.setDescription,
        decoration: const InputDecoration(
          hintText:
          '수업 내용, 목표, 진행 내용 등을 자유롭게 작성해주세요.',
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}