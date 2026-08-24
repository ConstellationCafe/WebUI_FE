import 'package:flutter/material.dart';

class TimeDropdown extends StatelessWidget {
  final DateTime? selectedTime;
  final ValueChanged<DateTime> onChanged;

  const TimeDropdown({
    super.key,
    required this.selectedTime,
    required this.onChanged,
  });

  static const List<String> _timeOptions = [
    '오전',
    '오후',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<DateTime?>(
      initialValue: selectedTime,
      decoration: const InputDecoration(
        labelText: '시간',
      ),
      items: [
        const DropdownMenuItem<DateTime?>(
          value: null,
          child: Text('전체'),
        ),
        ..._timeOptions.map(
              (time) {
            final now = DateTime.now();

            final value = time == '오전'
                ? DateTime(
              now.year,
              now.month,
              now.day,
              9,
            )
                : DateTime(
              now.year,
              now.month,
              now.day,
              14,
            );

            return DropdownMenuItem<DateTime?>(
              value: value,
              child: Text(time),
            );
          },
        ),
      ],
      onChanged: (time) {
        if (time == null) {
          return;
        }

        onChanged(time);
      },
    );
  }
}