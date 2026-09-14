import 'package:dio/dio.dart';

import '../../domain/model/lesson_record.dart';
import '../../data/dto/response/lesson_record_query_response.dart';
import '../../data/dto/request/lesson_record_query_request.dart';

class LessonRecordApi {
  static const base = String.fromEnvironment('BACKEND_URI');

  final Dio dio;

  LessonRecordApi({
    required this.dio,
  });

  Future<List<LessonRecordQueryResponse>> getLessonRecords(LessonRecordQueryRequest request) async {
    final response = await dio.get(
      '$base/api/academy/lesson-records',
      queryParameters: request.toJson(),
    );
    final data = response.data;
    if (data is! List) {
      throw Exception('수업 기록 조회 응답 형식이 올바르지 않습니다.');
    }
    return data
        .map(
          (item) => LessonRecordQueryResponse.fromJson(
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
}