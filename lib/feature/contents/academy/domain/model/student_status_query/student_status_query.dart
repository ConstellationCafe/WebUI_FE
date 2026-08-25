import 'package:freezed_annotation/freezed_annotation.dart';

import '../academy.dart';
import '../academy_class.dart';
import '../student.dart';
import '../../type/student_roster_status.dart';

part 'student_status_query.freezed.dart';

@freezed
abstract class StudentStatusQuery with _$StudentStatusQuery {
  const factory StudentStatusQuery({
    @Default([]) List<Academy> academies,
    @Default([]) List<AcademyClass> classes,
    @Default([]) List<Student> students,

    Academy? selectedAcademy,
    AcademyClass? selectedAcademyClass,
    Student? selectedStudent,
    StudentRosterStatus? selectedStatus,

    @Default(1) int page,
    @Default(20) int pageSize,
  }) = _StudentStatusQuery;
}