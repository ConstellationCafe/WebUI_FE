import 'package:constellation_cafe/feature/contents/academy/domain/model/subject.dart';
import 'package:dio/dio.dart';

import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/student.dart';
import '../../domain/model/teacher.dart';

class AcademyApi {
  static const base = String.fromEnvironment('BACKEND_URI');
  final Dio dio;

  AcademyApi({required this.dio});

  Future<List<Academy>> getAcademies() async {
    final response = await dio.get('$base/api/academy');
    final List<dynamic> data = response.data['response'];
    return data
        .map((json) => Academy.fromJson(json))
        .toList();
  }

  Future<List<AcademyClass>> getClasses(int academyId) async {
    final response = await dio.get('$base/api/academy/$academyId/classes');
    final List<dynamic> data = response.data['response'];
    return data
        .map((json) => AcademyClass.fromJson(json))
        .toList();
  }

  Future<List<Subject>> getSubjects(int academyId) async {
    final response = await dio.get('$base/api/academy/$academyId/subjects');
    final List<dynamic> data = response.data['response'];
    return data
        .map((json) => Subject.fromJson(json))
        .toList();
  }

  Future<List<Teacher>> getTeachers(int academyId) async {
    final response = await dio.get('$base/api/academy/$academyId/teachers');
    final List<dynamic> data = response.data['response'];
    return data
        .map((json) => Teacher.fromJson(json))
        .toList();
  }

  Future<List<Student>> getStudents(int academyId, int classId) async {
    final response = await dio.get('$base/api/academy/$academyId/classes/$classId/students');
    final List<dynamic> data = response.data['response'];
    return data
        .map((json) => Student.fromJson(json))
        .toList();
  }
}