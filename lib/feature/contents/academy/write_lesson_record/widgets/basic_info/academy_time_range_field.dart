import 'package:flutter/material.dart';

class AcademyTimeRangeField extends StatelessWidget {
  final DateTime? startTime;
  final DateTime? endTime;

  final ValueChanged<DateTime> onStartTimeChanged;
  final ValueChanged<DateTime> onEndTimeChanged;

  const AcademyTimeRangeField({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(
          context,
          '교육 시간',
          required: true,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: _timeButton(
                context,
                value: startTime,
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: startTime != null
                        ? TimeOfDay.fromDateTime(startTime!)
                        : const TimeOfDay(
                      hour: 10,
                      minute: 0,
                    ),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: colorScheme.primary,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (time != null) {
                    final now = DateTime.now();
                    onStartTimeChanged(
                      DateTime(
                        now.year,
                        now.month,
                        now.day,
                        time.hour,
                        time.minute,
                      ),
                    );
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Text('~'),
            ),
            Expanded(
              child: _timeButton(
                context,
                value: endTime,
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: endTime != null
                        ? TimeOfDay.fromDateTime(endTime!)
                        : const TimeOfDay(
                      hour: 12,
                      minute: 0,
                    ),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: colorScheme.primary,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (time != null) {
                    final now = DateTime.now();

                    onEndTimeChanged(
                      DateTime(
                        now.year,
                        now.month,
                        now.day,
                        time.hour,
                        time.minute,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _timeButton(
      BuildContext context, {
        required DateTime? value,
        required VoidCallback onPressed,
      }) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: const InputDecoration(
          suffixIcon: Icon(
            Icons.access_time,
          ),
        ),
        child: Text(
          value == null
              ? '--:--'
              : '${value.hour.toString().padLeft(2, '0')}:'
              '${value.minute.toString().padLeft(2, '0')}',
        ),
      ),
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
}