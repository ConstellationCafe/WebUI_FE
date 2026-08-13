import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';
import '../notifier/academy_notifier.dart';
import '../state/academy_form_state.dart';
import 'academy_section_card.dart';

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
    final notifier =
    ref.read(academyProvider.notifier);

    return AcademySectionCard(
      title: '기본 정보',
      icon: Icons.menu_book_rounded,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _dropdown(
                  context,
                  label: '아카데미 이름',
                  hint: '아카데미를 선택하세요',
                  value: state.selectedAcademy?.id,
                  items: state.academies
                      .map(
                        (academy) => DropdownMenuItem<String>(
                      value: academy.id,
                      child: Text(academy.name),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      notifier.selectAcademy(value);
                    }
                  },
                ),
              ),
              const SizedBox(
                width: ConstPadding.mediumPadding,
              ),
              Expanded(
                child: _dropdown(
                  context,
                  label: '분반',
                  hint: '분반을 선택하세요',
                  value: state.selectedClass,
                  items: state.classes
                      .map(
                        (className) => DropdownMenuItem<String>(
                      value: className,
                      child: Text(className),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      notifier.selectClass(value);
                    }
                  },
                ),
              ),
              const SizedBox(
                width: ConstPadding.mediumPadding,
              ),
              Expanded(
                child: _dropdown(
                  context,
                  label: '과목',
                  hint: '과목을 선택하세요',
                  value: state.selectedSubject,
                  items: state.subjects
                      .map(
                        (subject) => DropdownMenuItem<String>(
                      value: subject,
                      child: Text(subject),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      notifier.selectSubject(value);
                    }
                  },
                ),
              ),
            ],
          ),

          const SizedBox(
            height: ConstPadding.mediumPadding,
          ),

          Row(
            children: [
              Expanded(
                child: _dateField(
                  context,
                  state,
                  notifier,
                ),
              ),
              const SizedBox(
                width: ConstPadding.mediumPadding,
              ),
              Expanded(
                child: _timeRangeField(
                  context,
                  state,
                  notifier,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dropdown(
      BuildContext context, {
        required String label,
        required String hint,
        required String? value,
        required List<DropdownMenuItem<String>> items,
        required ValueChanged<String?> onChanged,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(context, label, required: true),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(hint),
          items: items,
          onChanged: onChanged,
          decoration: const InputDecoration(),
        ),
      ],
    );
  }

  Widget _dateField(
      BuildContext context,
      AcademyFormState state,
      dynamic notifier,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(context, '교육 일시', required: true),
        const SizedBox(height: 6),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
              initialDate:
              state.educationDate ?? DateTime.now(),
            );

            if (date != null) {
              notifier.setEducationDate(date);
            }
          },
          child: InputDecorator(
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.calendar_today_outlined),
            ),
            child: Text(
              state.educationDate == null
                  ? '날짜를 선택하세요'
                  : _formatDate(state.educationDate!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _timeRangeField(
      BuildContext context,
      AcademyFormState state,
      dynamic notifier,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(context, '교육 시간', required: true),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: _timeButton(
                context,
                value: state.startTime,
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(
                      hour: 10,
                      minute: 0,
                    ),
                  );

                  if (time != null) {
                    final now = DateTime.now();

                    notifier.setStartTime(
                      DateTime(
                        now.year,
                        now.month,
                        now.day,
                        time.hour,
                        time.minute,
                      ),
                    );
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('~'),
            ),
            Expanded(
              child: _timeButton(
                context,
                value: state.endTime,
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(
                      hour: 12,
                      minute: 0,
                    ),
                  );

                  if (time != null) {
                    final now = DateTime.now();

                    notifier.setEndTime(
                      DateTime(
                        now.year,
                        now.month,
                        now.day,
                        time.hour,
                        time.minute,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _timeButton(
      BuildContext context, {
        required DateTime? value,
        required VoidCallback onPressed,
      }) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.access_time),
        ),
        child: Text(
          value == null
              ? '--:--'
              : '${value.hour.toString().padLeft(2, '0')}:'
              '${value.minute.toString().padLeft(2, '0')}',
        ),
      ),
    );
  }

  Widget _label(
      BuildContext context,
      String text, {
        bool required = false,
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

  String _formatDate(DateTime date) {
    return '${date.year}. '
        '${date.month.toString().padLeft(2, '0')}. '
        '${date.day.toString().padLeft(2, '0')}';
  }
}