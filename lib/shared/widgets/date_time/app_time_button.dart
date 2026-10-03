import 'package:flutter/material.dart';

import '../../constants/date_time_picker_strings.dart';

/// 시각 표시와 선택 버튼. 누르면 호출부가 `showAppTimePicker`로 시간을 고른다.
/// [onPressed]가 null이면 비활성 상태로 보인다.
class AppTimeButton extends StatelessWidget {
  final DateTime? value;
  final VoidCallback? onPressed;
  final String? label;

  /// 값이 없을 때 보여줄 문구
  final String placeholder;

  const AppTimeButton({
    super.key,
    required this.value,
    required this.onPressed,
    this.label,
    this.placeholder = DateTimePickerStrings.emptyTime,
  });

  @override
  Widget build(BuildContext context) {
    final current = value;
    return _PickerBox(
      label: label,
      icon: Icons.access_time,
      text: current == null
          ? placeholder
          : DateTimePickerStrings.formatTime(current),
      isEmpty: current == null,
      onPressed: onPressed,
    );
  }
}

/// 날짜 표시와 선택 버튼. 누르면 호출부가 날짜 선택기를 연다.
/// [onPressed]가 null이면 비활성 상태로 보인다.
class AppDateButton extends StatelessWidget {
  final DateTime? value;
  final VoidCallback? onPressed;
  final String? label;

  /// 값이 없을 때 보여줄 문구
  final String placeholder;

  const AppDateButton({
    super.key,
    required this.value,
    required this.onPressed,
    this.label,
    this.placeholder = DateTimePickerStrings.selectDate,
  });

  @override
  Widget build(BuildContext context) {
    final current = value;
    return _PickerBox(
      label: label,
      icon: Icons.event_outlined,
      text: current == null
          ? placeholder
          : DateTimePickerStrings.formatDate(current),
      isEmpty: current == null,
      onPressed: onPressed,
    );
  }
}

/// 라벨이 있는 입력란 모양의 선택 버튼.
class _PickerBox extends StatelessWidget {
  final String? label;
  final IconData icon;
  final String text;
  final bool isEmpty;
  final VoidCallback? onPressed;

  const _PickerBox({
    required this.label,
    required this.icon,
    required this.text,
    required this.isEmpty,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final hintStyle = Theme.of(context).inputDecorationTheme.hintStyle;
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        // 라벨을 항상 위에 두어, 값이 없을 때 안내 문구와 라벨이 겹치지 않게 한다.
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabled: onPressed != null,
          suffixIcon: Icon(icon),
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: isEmpty ? hintStyle : null,
        ),
      ),
    );
  }
}
