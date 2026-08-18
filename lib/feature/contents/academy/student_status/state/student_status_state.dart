import 'package:freezed_annotation/freezed_annotation.dart';

import '../../write_lesson_record/domain/academy.dart';
import '../../write_lesson_record/domain/academy_class.dart';
import '../../write_lesson_record/domain/student.dart';
import '../../write_lesson_record/domain/subject.dart';
import '../domain/student_status_form.dart';

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