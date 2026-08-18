import 'package:dio/dio.dart';

import '../domain/model/student_status_form.dart';
import '../domain/response/student_status_response.dart';

class StudentStatusApi {
  final Dio dio;

  StudentStatusApi({required this.dio});

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

  Future<void> process(
      StudentStatusForm form,
      ) async {
    await dio.post(
      '/academy/student-status',
      data: {
        'academyId': form.academyId,
        'className': form.className,
        'studentId': form.studentId,
        'status': _statusToString(form.statusType),
        'subjectIds': form.subjectIds,
        'reason': form.reason,
      },
    );
  }

  String _statusToString(
      StudentStatusType status,
      ) {
    switch (status) {
      case StudentStatusType.graduation:
        return 'GRADUATION';

      case StudentStatusType.expulsion:
        return 'EXPULSION';

      case StudentStatusType.withdrawal:
        return 'WITHDRAWAL';
    }
  }
}