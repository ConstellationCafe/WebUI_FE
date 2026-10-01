import 'package:flutter/material.dart';

import 'package:constellation_cafe/core/constants/const_padding.dart';

import '../../constants/academy_constants.dart';
import '../../constants/academy_strings.dart';
import '../../domain/model/subject.dart';
import '../../domain/type/status_type.dart';
import 'status_radio_option.dart';

class StatusProcessForm<T extends StatusType> extends StatelessWidget {
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
    this.subjectSectionTitle = AcademyStrings.subjects,
    this.subjectHelperText = AcademyStrings.subjectOptionalHelper,
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
          AcademyStrings.processInfo,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: ConstPadding.mediumPadding),
        Text(
          AcademyStrings.processTypeRequired,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: ConstPadding.smallPadding),
        RadioGroup<T>(
          groupValue: selectedStatusType,
          onChanged: (value) {
            if (value != null) {
              onStatusChanged(value);
            }
          },
          child: Wrap(
            spacing: ConstPadding.mediumPadding,
            children: statuses
                .map((status) => StatusRadioOption<T>(value: status))
                .toList(),
          ),
        ),
        if (showSubjects) ...[
          const SizedBox(height: ConstPadding.mediumPadding),
          Text(
            subjectSectionTitle,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: ConstPadding.smallPadding),
          if (subjects.isEmpty)
            Text(
              AcademyStrings.noSelectableSubjects,
              style: Theme.of(context).textTheme.bodySmall,
            )
          else
            Wrap(
              spacing: ConstPadding.smallPadding,
              runSpacing: ConstPadding.smallPadding,
              children: subjects.map((subject) {
                final selected = selectedSubjects.any(
                  (selectedSubject) => selectedSubject.id == subject.id,
                );

                return FilterChip(
                  selected: selected,
                  label: Text(subject.name),
                  onSelected: (_) {
                    onSubjectChanged(subject);
                  },
                );
              }).toList(),
            ),
          const SizedBox(height: ConstPadding.tinyPadding),
          Text(subjectHelperText, style: Theme.of(context).textTheme.bodySmall),
        ],
        const SizedBox(height: ConstPadding.mediumPadding),
        TextField(
          onChanged: onReasonChanged,
          maxLines: AcademyConstants.statusReasonLines,
          decoration: const InputDecoration(
            labelText: AcademyStrings.processReason,
            hintText: AcademyStrings.processReasonHint,
          ),
        ),
      ],
    );
  }
}
