import 'package:dio/dio.dart';

import '../domain/model/lesson_record.dart';
import '../domain/dto/response/lesson_record_response.dart';
import '../domain/dto/request/lesson_record_request.dart';

class LessonRecordApi {
  static const base = String.fromEnvironment('BACKEND_URI');

  final Dio dio;

  LessonRecordApi({
    required this.dio,
  });

  Future<List<LessonRecordResponse>> getLessonRecords(LessonRecordRequest request) async {
    final response = await dio.get(
      '$base/api/academy/lesson-records',
      queryParameters: {
        if (request.academyId != null)
          'academyId': request.academyId,
        if (request.classId != null)
          'classId': request.classId,
        if (request.date != null)
          'date': _formatDate(request.date!),
        if (request.time != null)
          'time': request.time,
        if (request.subject != null)
          'subject': request.subject,
        if (request.teacherId != null)
          'teacherId': request.teacherId,
      },
    );
    final data = response.data;
    if (data is! List) {
      throw Exception('수업 기록 조회 응답 형식이 올바르지 않습니다.');
    }
    return data
        .map(
          (item) => LessonRecordResponse.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<void> createLessonRecord(LessonRecord record) async {
    await dio.post(
      '$base/api/academy/lesson-record',
      data: record.toJson(),
    );
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