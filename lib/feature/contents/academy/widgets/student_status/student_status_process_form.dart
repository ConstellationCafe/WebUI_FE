import 'package:flutter/material.dart';

import '../../../../../core/constants/const_padding.dart';

import '../../domain/type/student_status_type.dart';
import '../../state/student_status_state.dart';

class StudentStatusProcessForm
    extends StatelessWidget {
  final StudentStatusState state;

  final ValueChanged<StudentStatusType>
  onStatusChanged;

  final ValueChanged<String>
  onSubjectChanged;

  final ValueChanged<String>
  onReasonChanged;

  const StudentStatusProcessForm({
    super.key,
    required this.state,
    required this.onStatusChanged,
    required this.onSubjectChanged,
    required this.onReasonChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isGraduation =
        state.selectedStatusType ==
            StudentStatusType.graduation;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          '처리 정보',
          style: Theme.of(context)
              .textTheme
              .titleMedium,
        ),

        const SizedBox(
          height: ConstPadding.mediumPadding,
        ),

        Text(
          '처리 유형 *',
          style: Theme.of(context)
              .textTheme
              .labelLarge,
        ),

        const SizedBox(
          height: ConstPadding.smallPadding,
        ),

        Wrap(
          spacing: ConstPadding.mediumPadding,
          children: [
            _statusRadio(
              context,
              StudentStatusType.graduation,
              '졸업',
            ),
            _statusRadio(
              context,
              StudentStatusType.expulsion,
              '퇴학',
            ),
            _statusRadio(
              context,
              StudentStatusType.withdrawal,
              '자퇴',
            ),
          ],
        ),

        if (isGraduation) ...[
          const SizedBox(
            height: ConstPadding.mediumPadding,
          ),

          Text(
            '졸업 교과목',
            style: Theme.of(context)
                .textTheme
                .labelLarge,
          ),

          const SizedBox(
            height: ConstPadding.smallPadding,
          ),

          if (state.subjects.isEmpty)
            Text(
              '선택 가능한 교과목이 없습니다.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall,
            )
          else
            Wrap(
              spacing: ConstPadding.smallPadding,
              runSpacing: ConstPadding.smallPadding,
              children: state.subjects.map(
                    (subject) {
                  final selected =
                  state.selectedSubjectIds
                      .contains(subject.id);

                  return FilterChip(
                    selected: selected,
                    label: Text(subject.name),
                    onSelected: (_) {
                      onSubjectChanged(subject.name);
                    },
                  );
                },
              ).toList(),
            ),

          const SizedBox(
            height: ConstPadding.tinyPadding,
          ),

          Text(
            '교과목은 선택하지 않아도 됩니다.',
            style: Theme.of(context)
                .textTheme
                .bodySmall,
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
      StudentStatusType value,
      String label,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<StudentStatusType>(
          value: value,
          groupValue: state.selectedStatusType,
          onChanged: (value) {
            if (value != null) {
              onStatusChanged(value);
            }
          },
        ),
        Text(label),
      ],
    );
  }
}