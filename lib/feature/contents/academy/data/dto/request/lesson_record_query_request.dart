class LessonRecordQueryRequest {
  final String? academyId;
  final String? classId;
  final DateTime? date;
  final String? time;
  final String? subject;
  final String? teacherId;

  const LessonRecordQueryRequest({
    this.academyId,
    this.classId,
    this.date,
    this.time,
    this.subject,
    this.teacherId,
  });

  factory LessonRecordQueryRequest.fromJson(Map<String, dynamic> json) {
    return LessonRecordQueryRequest(
      academyId: json['academyId'] as String?,
      classId: json['classId'] as String?,
      date: json['date'] != null
          ? DateTime.tryParse(json['date'] as String)
          : null,
      time: json['time'] as String?,
      subject: json['subject'] as String?,
      teacherId: json['teacherId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (academyId != null) 'academyId': academyId,
      if (classId != null) 'classId': classId,
      if (date != null) 'date': _formatDate(date!),
      if (time != null) 'time': time,
      if (subject != null) 'subject': subject,
      if (teacherId != null) 'teacherId': teacherId,
    };
  }

  String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }
}