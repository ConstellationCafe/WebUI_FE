import 'package:flutter/material.dart';

import '../../constants/date_time_picker_strings.dart';

/// 시각 표시와 선택 버튼. 누르면 호출부가 `showAppTimePicker`로 시간을 고른다.
class AppTimeButton extends StatelessWidget {
  final DateTime? value;
  final VoidCallback onPressed;

  const AppTimeButton({
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
              ? DateTimePickerStrings.emptyTime
              : DateTimePickerStrings.formatTime(value!),
        ),
      ),
    );
  }
}
