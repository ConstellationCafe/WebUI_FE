import 'package:flutter/material.dart';

import 'package:constellation_cafe/feature/modules/academy/constants/academy_strings.dart';

/// 수업 시작·종료 시각 표시와 선택 버튼.
class AcademyTimeButton extends StatelessWidget {
  final DateTime? value;
  final VoidCallback onPressed;

  const AcademyTimeButton({
    super.key,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: const InputDecoration(suffixIcon: Icon(Icons.access_time)),
        child: Text(
          value == null
              ? AcademyStrings.emptyTime
              : AcademyStrings.formatTime(value!),
        ),
      ),
    );
  }
}
