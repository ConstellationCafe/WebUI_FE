import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/modules/academy/constants/academy_constants.dart';

import '../academy_field_label.dart';

/// 필수 표시 제목이 붙은 수업 기록 선택 필드.
class AcademyLabeledDropdown<T> extends StatelessWidget {
  final String label;
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const AcademyLabeledDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AcademyFieldLabel(label, isRequired: true),
        const SizedBox(height: AcademyConstants.fieldLabelGap),
        DropdownButtonFormField<T>(
          // 선택 값은 notifier state가 소유한다. initialValue로 바꾸면 선택 초기화가
          // 반영되지 않으므로 controlled value를 유지한다.
          // ignore: deprecated_member_use
          value: value,
          hint: Text(hint),
          items: items,
          onChanged: onChanged,
          decoration: const InputDecoration(),
        ),
      ],
    );
  }
}
