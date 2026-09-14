import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onChanged;

  const DateField({
    super.key,
    required this.selectedDate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
          initialDate:
          selectedDate ?? DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                textButtonTheme:
                TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor:
                    colorScheme.secondary,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );

        if (date != null) {
          onChanged(date);
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: '날짜',
          suffixIcon: Icon(
            Icons.calendar_today_outlined,
          ),
        ),
        child: Text(
          selectedDate == null
              ? '전체'
              : _formatDate(selectedDate!),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}. '
        '${date.month.toString().padLeft(2, '0')}. '
        '${date.day.toString().padLeft(2, '0')}';
  }
}