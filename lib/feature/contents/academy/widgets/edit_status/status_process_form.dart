import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../domain/model/subject.dart';
import '../../domain/type/status_type.dart';

class StatusProcessForm<T extends StatusType>
    extends StatelessWidget {
  final List<T> statuses;

  final List<Subject> subjects;
  final T? selectedStatusType;
  final List<Subject> selectedSubjects;
  final String reason;

  final ValueChanged<T> onStatusChanged;
  final ValueChanged<Subject> onSubjectChanged;
  final ValueChanged<String> onReasonChanged;

  final bool Function(T status)? showSubjectsWhen;
  final String subjectSectionTitle;
  final String subjectHelperText;

  const StatusProcessForm({
    super.key,
    required this.statuses,
    required this.subjects,
    required this.selectedStatusType,
    required this.selectedSubjects,
    required this.reason,
    required this.onStatusChanged,
    required this.onSubjectChanged,
    required this.onReasonChanged,
    this.showSubjectsWhen,
    this.subjectSectionTitle = '교과목',
    this.subjectHelperText = '교과목은 선택하지 않아도 됩니다.',
  });

  @override
  Widget build(BuildContext context) {
    final showSubjects =
        selectedStatusType != null &&
            showSubjectsWhen?.call(selectedStatusType as T) == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '처리 정보',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: ConstPadding.mediumPadding,
        ),
        Text(
          '처리 유형 *',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: ConstPadding.smallPadding,
        ),
        Wrap(
          spacing: ConstPadding.mediumPadding,
          children: statuses
              .map(
                (status) => _statusRadio(
              context,
              status,
            ),
          )
              .toList(),
        ),
        if (showSubjects) ...[
          const SizedBox(
            height: ConstPadding.mediumPadding,
          ),
          Text(
            subjectSectionTitle,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(
            height: ConstPadding.smallPadding,
          ),
          if (subjects.isEmpty)
            Text(
              '선택 가능한 교과목이 없습니다.',
              style: Theme.of(context).textTheme.bodySmall,
            )
          else
            Wrap(
              spacing: ConstPadding.smallPadding,
              runSpacing: ConstPadding.smallPadding,
              children: subjects.map(
                    (subject) {
                  final selected = selectedSubjects.any(
                        (selectedSubject) =>
                    selectedSubject.id == subject.id,
                  );

                  return FilterChip(
                    selected: selected,
                    label: Text(subject.name),
                    onSelected: (_) {
                      onSubjectChanged(subject);
                    },
                  );
                },
              ).toList(),
            ),
          const SizedBox(
            height: ConstPadding.tinyPadding,
          ),
          Text(
            subjectHelperText,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
        const SizedBox(
          height: ConstPadding.mediumPadding,
        ),
        TextField(
          onChanged: onReasonChanged,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: '처리 사유',
            hintText: '처리 사유를 입력하세요',
          ),
        ),
      ],
    );
  }

  Widget _statusRadio(
      BuildContext context,
      T value,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<T>(
          value: value,
          groupValue: selectedStatusType,
          activeColor:
          Theme.of(context).colorScheme.secondary,
          onChanged: (value) {
            if (value != null) {
              onStatusChanged(value);
            }
          },
        ),
        Text(value.label),
      ],
    );
  }
}