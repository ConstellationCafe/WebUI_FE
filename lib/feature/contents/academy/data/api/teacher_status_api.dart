import 'package:dio/dio.dart';

import 'package:constellation_cafe/core/network/discordBot/Translator.dart';

import '../dto/request/status_query_request.dart';
import '../dto/response/teacher_status_list_response.dart';
import '../dto/response/teacher_status_response.dart';

import '../../domain/model/teacher_status_form.dart';
import '../../domain/type/teacher_status_type.dart';

class TeacherStatusApi {
  static const base = String.fromEnvironment('BACKEND_URI');

  final APITranslator translator;
  final Dio dio;

  TeacherStatusApi({
    required this.translator,
    required this.dio,
  });

  Future<TeacherStatusResponse> getStatusOptions({
    int? academyId,
    int? classId,
  }) async {
    final response = await dio.get(
      '$base/api/academy/teacher-status/options',
      queryParameters: {
        if (academyId != null)
          'academyId': academyId,
        if (classId != null)
          'classId': classId,
      },
    );

    return TeacherStatusResponse.fromJson(
      response.data['response']
      as Map<String, dynamic>,
    );
  }

  Future<TeacherStatusListResponse> getTeacherStatuses(
      StatusQueryRequest request,
      ) async {
    final response = await dio.get(
      '$base/api/academy/teacher-status',
      queryParameters: request.toJson(),
    );

    final data =
    response.data['response'];

    if (data is! Map<String, dynamic>) {
      throw Exception(
        '학생 상태 조회 응답 형식이 올바르지 않습니다.',
      );
    }

    return TeacherStatusListResponse.fromJson(
      data,
    );
  }

  Future<void> process(TeacherStatusForm form) async {
    String path = '';
    List args = [];

    switch (form.statusType) {
      case TeacherStatusType.retire:
        path = '/ConstellationAPI/AcademyAPI/retire_teacher';
        args = [
          form.teacherDiscordId,
          form.academyName,
          form.className,
        ];

      case TeacherStatusType.discipline:
        path = '/ConstellationAPI/AcademyAPI/discipline_command';
        args = [
          form.teacherDiscordId,
          form.academyName,
          form.className,
        ];
    }

    await translator.request(path, args);
  }
}