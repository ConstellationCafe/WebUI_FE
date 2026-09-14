import '../../data/api/academy_api.dart';
import '../../data/api/lesson_record_api.dart';
import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/lesson_record.dart';
import '../../domain/model/student.dart';
import '../../domain/model/subject.dart';
import '../../domain/model/teacher.dart';
import '../dto/request/lesson_record_query_request.dart';
import '../dto/response/lesson_record_query_response.dart';

class LessonRecordRepository {
  final AcademyApi academyApi;
  final LessonRecordApi lessonRecordApi;

  const LessonRecordRepository({
    required this.academyApi,
    required this.lessonRecordApi,
  });

  Future<List<Academy>> getAcademies() async {
    return await academyApi.getAcademies();
  }

  Future<List<AcademyClass>> getClasses(
      int academyId,
      ) async {
    return await academyApi.getClasses(academyId);
  }

  Future<List<Subject>> getSubjects(
      int academyId,
      ) async {
    return await academyApi.getSubjects(academyId);
  }

  Future<List<Teacher>> getTeachers(
      int academyId,
      ) async {
    return await academyApi.getTeachers(academyId);
  }

  Future<List<Student>> getStudents(
      int academyId,
      int classId,
      ) async {
    return await academyApi.getStudents(
      academyId,
      classId,
    );
  }

  Future<void> createLessonRecord(
      LessonRecord lessonRecord,
      ) async {
    await lessonRecordApi.createLessonRecord(
      lessonRecord,
    );
  }

  Future<List<LessonRecordQueryResponse>> getLessonRecords({
    int? academyId,
    int? classId,
    DateTime? date,
    DateTime? time,
    String? subject,
    String? teacherId,
  }) async {
    final request = LessonRecordQueryRequest(
      academyId: academyId,
      classId: classId,
      date: date,
      time: time?.toString(),
      subject: subject,
      teacherId: teacherId,
    );

    return await lessonRecordApi.getLessonRecords(request);
  }
}