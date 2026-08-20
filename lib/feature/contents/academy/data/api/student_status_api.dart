import 'package:dio/dio.dart';

import 'package:constellation_cafe/core/network/discordBot/Translator.dart';
import '../../data/dto/response/student_status_response.dart';
import '../../domain/model/student_status_form.dart';
import '../../domain/type/student_status_type.dart';

class StudentStatusApi {
  final APITranslator translator;
  final Dio dio;

  StudentStatusApi({
    required this.translator,
    required this.dio
  });

  Future<StudentStatusResponse> getOptions({
    String? academyId,
    String? className,
  }) async {
    final response = await dio.get(
      '/academy/student-status/options',
      queryParameters: {
        if (academyId != null) 'academyId': academyId,
        if (className != null) 'className': className,
      },
    );

    return StudentStatusResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  // FIXME : args = [discordID, academy_name, academy_class, subject]가 되게 수정
  Future<void> process(StudentStatusForm form) async {
    /* 학생의 졸업 / 자퇴 / 퇴학 처리 */
    String path = "";
    List args = [];
    switch (form.statusType) {
      case StudentStatusType.graduation:
        path = "/ConstellationAPI/AcademyAPI/graduate_approve";
        args = [form.studentId, form.academyId, form.className, form.subjectIds];
      case StudentStatusType.expulsion:
        path = "/ConstellationAPI/AcademyAPI/dropout_student";
        args = [form.studentId, form.academyId, form.className];
      case StudentStatusType.withdrawal:
        path = "/ConstellationAPI/AcademyAPI/suspended_command";
        args = [form.studentId, form.academyId, form.className];
    }
    final res = await translator.request(path, args);
    return res["payload"]["result"];
  }
}