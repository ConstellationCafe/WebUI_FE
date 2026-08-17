import 'package:flutter/material.dart';

class AcademyDateField extends StatelessWidget {
  final DateTime? date;
  final ValueChanged<DateTime> onChanged;

  const AcademyDateField({
    super.key,
    required this.date,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(
          context,
          '교육 일시',
          required: true,
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: () async {
            final selectedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
              initialDate: date ?? DateTime.now(),
            );

            if (selectedDate != null) {
              onChanged(selectedDate);
            }
          },
          child: InputDecorator(
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.calendar_today_outlined,
              ),
            ),
            child: Text(
              date == null
                  ? '날짜를 선택하세요'
                  : _formatDate(date!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _label(
      BuildContext context,
      String text, {
        bool required = false,
      }) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelLarge,
        children: [
          TextSpan(text: text),
          if (required)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}. '
        '${date.month.toString().padLeft(2, '0')}. '
        '${date.day.toString().padLeft(2, '0')}';
  }
}