import 'package:constellation_cafe/feature/contents/academy/write_lesson_record/domain/subject.dart';
import 'package:dio/dio.dart';

import '../domain/academy.dart';
import '../domain/academy_class.dart';
import '../domain/teacher.dart';
import '../domain/member.dart';
import '../domain/lesson_record.dart';

class AcademyApi {
  static const base = String.fromEnvironment('BACKEND_URI');

  final Dio dio;

  AcademyApi({required this.dio});

  Future<List<Academy>> getAcademies() async {
    final response = await dio.get(
      '$base/api/academy',
    );

    final List<dynamic> data = response.data['response'];
    return data
        .map((json) => Academy.fromJson(json))
        .toList();
  }

  Future<List<AcademyClass>> getClasses(String academyId) async {
    final response = await dio.get(
      '$base/api/academy/$academyId/classes',
    );
    final List<dynamic> data = response.data['response'];
    return data
        .map((json) => AcademyClass.fromJson(json))
        .toList();
  }

  Future<List<Subject>> getSubjects(String academyId) async {
    final response = await dio.get(
      '$base/api/academy/$academyId/subjects',
    );
    final List<dynamic> data = response.data['response'];
    return data
        .map((json) => Subject.fromJson(json))
        .toList();
  }

  Future<List<AcademyTeacher>> getTeachers(String academyId) async {
    final response = await dio.get(
      '$base/api/academy/$academyId/teachers',
    );
    final List<dynamic> data = response.data['response'];
    return data
        .map((json) => AcademyTeacher.fromJson(json))
        .toList();
  }

  Future<List<ChatMember>> getStudents(
      String academyId,
      String className,
      ) async {
    final response = await dio.get(
      '$base/api/academy/$academyId/classes/$className/students',
    );

    final List<dynamic> data = response.data['response'];
    return data
        .map((json) => ChatMember.fromJson(json))
        .toList();
  }

  Future<void> createLessonRecord(
      LessonRecord record,
      ) async {
    await dio.post(
      '$base/api/academy/lesson-record',
      data: record.toJson(),
    );
  }
}