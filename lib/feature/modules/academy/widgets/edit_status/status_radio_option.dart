import 'package:flutter/material.dart';

import '../../domain/type/status_type.dart';

/// 처리 유형 radio 한 개와 이름. 선택 값은 상위 [RadioGroup]이 관리한다.
class StatusRadioOption<T extends StatusType> extends StatelessWidget {
  final T value;

  const StatusRadioOption({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<T>(
          value: value,
          activeColor: Theme.of(context).colorScheme.secondary,
        ),
        Text(value.label),
      ],
    );
  }
}
