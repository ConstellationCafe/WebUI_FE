class LessonRecordQueryResponse {
  final String id;
  final String academyName;
  final String className;
  final String subjectName;
  final DateTime educationDate;
  final DateTime? startTime;
  final DateTime? endTime;
  final Duration educationDuration;
  final String mainTeacherName;
  final String description;
  final int memberCount;
  final bool canModify;

  const LessonRecordQueryResponse({
    required this.id,
    required this.academyName,
    required this.className,
    required this.subjectName,
    required this.educationDate,
    required this.startTime,
    required this.endTime,
    required this.educationDuration,
    required this.mainTeacherName,
    required this.description,
    required this.memberCount,
    required this.canModify,
  });

  factory LessonRecordQueryResponse.fromJson(Map<String, dynamic> json) {
    return LessonRecordQueryResponse(
      id: json['id'].toString(),
      academyName: json['academyName'] ?? '',
      className: json['className'] ?? '',
      subjectName: json['subject'] ?? '',
      educationDate: DateTime.parse(json['educationDate']),
      startTime: _parseTime(json['startTime']),
      endTime: _parseTime(json['endTime']),
      educationDuration: Duration(minutes: json['educationDuration'] ?? 0),
      mainTeacherName: json['mainTeacherName'] ?? '',
      description: json['description'] ?? '',
      memberCount: json['memberCount'] ?? 0,
      canModify: json['canModify'] as bool? ?? false,
    );
  }
  static DateTime? _parseTime(dynamic value) {
    if (value == null) return null;
    final parts = value.toString().split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}
