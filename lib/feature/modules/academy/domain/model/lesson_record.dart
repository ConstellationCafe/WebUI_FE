class LessonRecord {
  final int academyId;
  final String className;
  final String subjectName;

  final DateTime educationDate;
  final DateTime startTime;
  final DateTime endTime;
  final Duration educationDuration;

  final String mainTeacherId;
  final List<String> coTeacherIds;

  final List<String> memberIds;

  final String description;

  const LessonRecord({
    required this.academyId,
    required this.className,
    required this.subjectName,
    required this.educationDate,
    required this.startTime,
    required this.endTime,
    required this.educationDuration,
    required this.mainTeacherId,
    required this.coTeacherIds,
    required this.memberIds,
    required this.description,
  });

  String _formatTime(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';

  Map<String, dynamic> toJson() {
    return {
      'academyId': academyId,
      'className': className,
      'subject': subjectName,
      'educationDate': educationDate.toIso8601String(),
      'startTime': _formatTime(startTime),
      'endTime': _formatTime(endTime),
      'educationDuration': educationDuration.inMinutes,
      'mainTeacherId': mainTeacherId,
      'coTeacherIds': coTeacherIds,
      'memberIds': memberIds,
      'description': description,
    };
  }
}
