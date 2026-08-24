import 'package:dio/dio.dart';

import 'package:constellation_cafe/core/network/discordBot/Translator.dart';
import '../../data/dto/response/student_status_response.dart';
import '../../domain/model/student_status_form.dart';
import '../../domain/type/student_status_type.dart';

class StudentStatusApi {
  static const base = String.fromEnvironment('BACKEND_URI');
  final APITranslator translator;
  final Dio dio;

  StudentStatusApi({
    required this.translator,
    required this.dio
  });

  Future<StudentStatusResponse> getStatusOptions({
    int? academyId,
    int? classId,
  }) async {
    final response = await dio.get(
      '$base/api/academy/student-status/options',
      queryParameters: {
        if (academyId != null) 'academyId': academyId,
        if (classId != null) 'classId': classId,
      },
    );

    return StudentStatusResponse.fromJson(
      response.data['response'] as Map<String, dynamic>,
    );
  }

  Future<void> process(StudentStatusForm form) async {
    /* 학생의 졸업 / 자퇴 / 퇴학 처리 */
    String path = "";
    List args = [];
    switch (form.statusType) {
      case StudentStatusType.graduation:
        path = "/ConstellationAPI/AcademyAPI/graduate_approve";
        args = [form.studentDiscordId, form.academyName, form.className, form.subjectIds];
      case StudentStatusType.expulsion:
        path = "/ConstellationAPI/AcademyAPI/dropout_student";
        args = [form.studentDiscordId, form.academyName, form.className];
      case StudentStatusType.withdrawal:
        path = "/ConstellationAPI/AcademyAPI/suspended_command";
        args = [form.studentDiscordId, form.academyName, form.className];
    }
    final res = await translator.request(path, args);
    return res["payload"]["result"];
  }
}