import 'lesson_time_range.dart';

class LessonRecordUpdate {
  final String subject;
  final DateTime educationDate;
  final DateTime startTime;
  final DateTime endTime;
  final String description;

  const LessonRecordUpdate({
    required this.subject,
    required this.educationDate,
    required this.startTime,
    required this.endTime,
    required this.description,
  });

  int get educationDuration =>
      LessonTimeRange.duration(startTime, endTime).inMinutes;

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'educationDate': DateTime(
        educationDate.year,
        educationDate.month,
        educationDate.day,
      ).toIso8601String(),
      'startTime': _formatTime(startTime),
      'endTime': _formatTime(endTime),
      'educationDuration': educationDuration,
      'description': description,
    };
  }

  String _formatTime(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:'
      '${time.minute.toString().padLeft(2, '0')}:00';
}
