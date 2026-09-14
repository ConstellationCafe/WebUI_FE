import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/status_view/status_view.dart';
import '../../domain/model/student.dart';
import '../../domain/model/subject.dart';

import '../../domain/model/student_status_form.dart';
import '../../domain/model/student_status_list/student_status_list.dart';

import '../../domain/type/student_roster_status.dart';

import '../api/student_status_api.dart';
import '../dto/request/status_query_request.dart';

class StudentStatusRepository {
  final StudentStatusApi api;

  const StudentStatusRepository({
    required this.api,
  });

  Future<List<Academy>> getAcademies() async {
    final response =
    await api.getStatusOptions();

    return response.academies
      .map(
        (academy) => Academy(
          id: academy.id,
          name: academy.name,
        ),
      )
      .toList();
  }

  Future<List<AcademyClass>> getClasses(int academyId) async {
    final response = await api.getStatusOptions(
      academyId: academyId,
    );

    return response.classes
      .map(
        (academyClass) => AcademyClass(
          id: academyClass.id,
          classNumber:
          academyClass.classNumber,
          state: academyClass.state,
        ),
      )
      .toList();
  }

  Future<List<Subject>> getSubjects(int academyId) async {
    final response = await api.getStatusOptions(
      academyId: academyId,
    );

    return response.subjects
      .map(
        (subject) => Subject(
          id: subject.id,
          name: subject.name,
        ),
      )
      .toList();
  }

  Future<List<Student>> getStudents(
      int academyId,
      int classId,
      ) async {
    final response =
    await api.getStatusOptions(
      academyId: academyId,
      classId: classId,
    );

    return response.students
      .map(
        (student) => Student(
          sk: student.sk,
          discordID:
          student.discordID,
          name: student.name,
        ),
      )
      .toList();
  }

  Future<StudentStatusList>
  getStudentStatuses({
    int? academyId,
    int? classId,
    String? academyMemberId,
    StudentRosterStatus? status,
    int page = 1,
    int size = 20,
  }) async {
    final request = StatusQueryRequest(
      academyId: academyId,
      classId: classId,
      academyMemberId: academyMemberId,
      status: status,
      page: page,
      size: size,
    );

    final response = await api.getStudentStatuses(
      request,
    );

    return StudentStatusList(
      items: response.items
        .map<StatusView<Student, StudentRosterStatus>>(
          (item) => StatusView<Student, StudentRosterStatus>(
            academyMember: item.academyMember,
            academy: item.academy,
            academyClass: item.academyClass,
            status: item.status,
            statusChangedAt: item.statusChangedAt,
            reason: item.reason,
          ),
        )
        .toList(),
      totalCount: response.summary.totalCount,
      enrolledCount: response.summary.enrolledCount,
      graduationCount: response.summary.graduationCount,
      expulsionCount: response.summary.expulsionCount,
      withdrawalCount: response.summary.withdrawalCount,
      currentPage: response.pagination.currentPage,
      totalPages: response.pagination.totalPages,
    );
  }

  Future<void> process(StudentStatusForm form) async {
    await api.process(form);
  }
}