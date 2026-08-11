import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/ConstPadding.dart';
import '../domain/teacher.dart';
import '../notifier/academy_notifier.dart';
import '../state/academy_form_state.dart';
import 'academy_section_card.dart';

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
    ref.read(academyNotifierProvider.notifier);

    return AcademySectionCard(
      title: '교사 정보',
      icon: Icons.person_outline_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _mainTeacher(
                  context,
                  notifier,
                ),
              ),
              const SizedBox(
                width: ConstPadding.mediumPadding,
              ),
              Expanded(
                child: _coTeachers(
                  context,
                  notifier,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mainTeacher(
      BuildContext context,
      dynamic notifier,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(
          context,
          '담당 교사 (나)',
          required: true,
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: state.mainTeacher?.id,
          hint: const Text('담당 교사를 선택하세요'),
          items: state.teachers
              .map(
                (teacher) => DropdownMenuItem<String>(
              value: teacher.id,
              child: Text(teacher.name),
            ),
          )
              .toList(),
          onChanged: (value) {
            if (value == null) return;

            final teacher = state.teachers.firstWhere(
                  (element) => element.id == value,
            );

            notifier.selectMainTeacher(teacher);
          },
        ),
      ],
    );
  }

  Widget _coTeachers(
      BuildContext context,
      dynamic notifier,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(
          context,
          '함께 가르친 교사',
          required: false,
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          hint: const Text('교사 이름을 선택하세요'),
          items: state.teachers
              .where(
                (teacher) =>
            teacher.id != state.mainTeacher?.id,
          )
              .map(
                (teacher) => DropdownMenuItem<String>(
              value: teacher.id,
              child: Text(teacher.name),
            ),
          )
              .toList(),
          onChanged: (value) {
            if (value == null) return;

            final teacher = state.teachers.firstWhere(
                  (element) => element.id == value,
            );

            notifier.toggleCoTeacher(teacher);
          },
        ),

        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: state.selectedCoTeachers
              .map(
                (teacher) => Chip(
              label: Text(teacher.name),
              onDeleted: () {
                notifier.toggleCoTeacher(teacher);
              },
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  Widget _label(
      BuildContext context,
      String text, {
        required bool required,
      }) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelLarge,
        children: [
          TextSpan(text: text),
          if (required)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}