import 'package:dio/dio.dart';

import '../domain/model/lesson_record_summary.dart';

class LessonRecordApi {
  static const base = String.fromEnvironment(
    'BACKEND_URI',
  );

  final Dio dio;

  LessonRecordApi({
    required this.dio,
  });

  Future<List<LessonRecordSummary>> getLessonRecords({
    String? academyId,
    String? classId,
    DateTime? date,
    String? time,
    String? subject,
    String? teacherId,
  }) async {
    final response = await dio.get(
      '$base/api/academy/lesson-records',
      queryParameters: {
        if (academyId != null &&
            academyId.isNotEmpty)
          'academyId': academyId,

        if (classId != null &&
            classId.isNotEmpty)
          'classId': classId,

        if (date != null)
          'date': _formatDate(date),

        if (time != null &&
            time.isNotEmpty)
          'time': time,

        if (subject != null &&
            subject.isNotEmpty)
          'subject': subject,

        if (teacherId != null &&
            teacherId.isNotEmpty)
          'teacherId': teacherId,
      },
    );

    final data = response.data;

    if (data is! List) {
      throw Exception(
        '수업 기록 조회 응답 형식이 올바르지 않습니다.',
      );
    }

    return data
        .map(
          (item) => LessonRecordSummary.fromJson(
        item as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  String _formatDate(DateTime date) {
    final month = date.month
        .toString()
        .padLeft(2, '0');

    final day = date.day
        .toString()
        .padLeft(2, '0');

    return '${date.year}-$month-$day';
  }
}