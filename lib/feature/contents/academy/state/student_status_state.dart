import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/model/academy.dart';
import '../domain/model/academy_class.dart';
import '../domain/model/student.dart';
import '../domain/model/subject.dart';
import '../domain/model/student_status_form.dart';

part 'student_status_state.freezed.dart';

@freezed
abstract class StudentStatusState
    with _$StudentStatusState {
  const factory StudentStatusState({
    @Default(false)
    bool isLoading,

    @Default(false)
    bool isProcessing,

    @Default([])
    List<Academy> academies,

    @Default([])
    List<AcademyClass> classes,

    @Default([])
    List<AcademyStudent> students,

    @Default([])
    List<Subject> subjects,

    String? selectedAcademyId,

    String? selectedClassName,

    String? selectedStudentId,

    StudentStatusType? selectedStatusType,

    @Default([])
    List<String> selectedSubjectIds,

    @Default('')
    String reason,

    String? errorMessage,
  }) = _StudentStatusState;
}