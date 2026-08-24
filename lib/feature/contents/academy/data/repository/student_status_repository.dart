import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/student.dart';
import '../../domain/model/subject.dart';
import '../../domain/model/student_status_form.dart';
import '../api/student_status_api.dart';

class StudentStatusRepository {
  final StudentStatusApi api;

  const StudentStatusRepository({
    required this.api,
  });

  Future<List<Academy>> getAcademies() async {
    final response = await api.getStatusOptions();
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
            classNumber: academyClass.classNumber,
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
    final response = await api.getStatusOptions(
      academyId: academyId,
      classId: classId,
    );
    return response.students
        .map(
          (student) => Student(
            sk: student.sk,
            discordID: student.discordID,
            name: student.name,
          ),
        )
        .toList();
  }

  Future<void> process(StudentStatusForm form) async {
    await api.process(form);
  }
}