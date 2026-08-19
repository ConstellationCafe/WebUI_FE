class LessonRecordRequest {
  final String? academyId;
  final String? classId;
  final DateTime? date;
  final String? time;
  final String? subject;
  final String? teacherId;

  const LessonRecordRequest({
    this.academyId,
    this.classId,
    this.date,
    this.time,
    this.subject,
    this.teacherId,
  });

  factory LessonRecordRequest.fromJson(Map<String, dynamic> json) {
    return LessonRecordRequest(
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
}