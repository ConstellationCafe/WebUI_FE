import 'package:dio/dio.dart';

import 'package:constellation_cafe/core/network/discordBot/Translator.dart';

import '../dto/request/student_status_query_request.dart';
import '../dto/response/student_status_list_response.dart';
import '../dto/response/student_status_response.dart';

import '../../domain/model/student_status_form.dart';
import '../../domain/type/student_status_type.dart';

class StudentStatusApi {
  static const base =
  String.fromEnvironment('BACKEND_URI');

  final APITranslator translator;
  final Dio dio;

  StudentStatusApi({
    required this.translator,
    required this.dio,
  });

  Future<StudentStatusResponse>
  getStatusOptions({
    int? academyId,
    int? classId,
  }) async {
    final response = await dio.get(
      '$base/api/academy/student-status/options',
      queryParameters: {
        if (academyId != null)
          'academyId': academyId,
        if (classId != null)
          'classId': classId,
      },
    );

    return StudentStatusResponse.fromJson(
      response.data['response']
      as Map<String, dynamic>,
    );
  }

  Future<StudentStatusListResponse>
  getStudentStatuses(
      StudentStatusQueryRequest request,
      ) async {
    final response = await dio.get(
      '$base/api/academy/student-status',
      queryParameters: request.toJson(),
    );

    final data =
    response.data['response'];

    if (data is! Map<String, dynamic>) {
      throw Exception(
        '학생 상태 조회 응답 형식이 올바르지 않습니다.',
      );
    }

    return StudentStatusListResponse.fromJson(
      data,
    );
  }

  Future<void> process(
      StudentStatusForm form,
      ) async {
    String path = '';
    List args = [];

    switch (form.statusType) {
      case StudentStatusType.graduation:
        path =
        '/ConstellationAPI/AcademyAPI/graduate_approve';

        args = [
          form.studentDiscordId,
          form.academyName,
          form.className,
          form.subjectIds,
        ];

      case StudentStatusType.expulsion:
        path =
        '/ConstellationAPI/AcademyAPI/dropout_student';

        args = [
          form.studentDiscordId,
          form.academyName,
          form.className,
        ];

      case StudentStatusType.withdrawal:
        path =
        '/ConstellationAPI/AcademyAPI/suspended_command';

        args = [
          form.studentDiscordId,
          form.academyName,
          form.className,
        ];
    }

    await translator.request(
      path,
      args,
    );
  }
}