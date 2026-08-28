import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/teacher.dart';

import '../../domain/model/teacher_status_form.dart';
import '../../domain/model/teacher_status_list/teacher_status_list.dart';
import '../../domain/model/status_view/status_view.dart';

import '../../domain/type/teacher_roster_status.dart';

import '../api/teacher_status_api.dart';
import '../dto/request/status_query_request.dart';

class TeacherStatusRepository {
  final TeacherStatusApi api;

  const TeacherStatusRepository({
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

  Future<List<AcademyClass>> getClasses(
      int academyId,
      ) async {
    final response =
    await api.getStatusOptions(
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

  Future<List<Teacher>> getTeachers(
      int academyId,
      int classId,
      ) async {
    final response =
    await api.getStatusOptions(
      academyId: academyId,
      classId: classId,
    );

    return response.teachers
        .map(
          (teacher) => Teacher(
        sk: teacher.sk,
        discordID:
        teacher.discordID,
        name: teacher.name,
      ),
    )
        .toList();
  }

  Future<TeacherStatusList>
  getTeacherStatuses({
    int? academyId,
    int? classId,
    String? academyMemberId,
    TeacherRosterStatus? status,
    int page = 1,
    int size = 20,
  }) async {
    final request =
    StatusQueryRequest<TeacherRosterStatus>(
      academyId: academyId,
      classId: classId,
      academyMemberId: academyMemberId,
      status: status,
      page: page,
      size: size,
    );

    final response =
    await api.getTeacherStatuses(
      request,
    );

    return TeacherStatusList(
      items: response.items
          .map(
            (item) =>
            StatusView<
                Teacher,
                TeacherRosterStatus>(
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
      retirementCount: response.summary.retirementCount,
      disciplinaryCount: response.summary.disciplinaryCount,
      currentPage: response.pagination.currentPage,
      totalPages: response.pagination.totalPages,
    );
  }

  Future<void> process(
      TeacherStatusForm form,
      ) async {
    await api.process(form);
  }
}