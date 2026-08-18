import '../domain/model/academy.dart';
import '../domain/model/academy_class.dart';
import '../domain/model/subject.dart';
import '../domain/model/teacher.dart';
import '../domain/model/member.dart';

const Object _academyFormStateUnset = Object();

class AcademyFormState {
  final bool isLoading;
  final bool isSaving;

  final List<Academy> academies;
  final List<AcademyClass> classes;
  final List<Subject> subjects;

  final List<AcademyTeacher> teachers;
  final List<ChatMember> members;

  final Academy? selectedAcademy;
  final String? selectedClass;
  final String? selectedSubject;

  final AcademyTeacher? mainTeacher;
  final List<AcademyTeacher> selectedCoTeachers;

  final List<ChatMember> selectedMembers;

  final DateTime? educationDate;
  final DateTime? startTime;
  final DateTime? endTime;

  final String description;

  final String? errorMessage;

  const AcademyFormState({
    this.isLoading = false,
    this.isSaving = false,
    this.academies = const [],
    this.classes = const [],
    this.subjects = const [],
    this.teachers = const [],
    this.members = const [],
    this.selectedAcademy,
    this.selectedClass,
    this.selectedSubject,
    this.mainTeacher,
    this.selectedCoTeachers = const [],
    this.selectedMembers = const [],
    this.educationDate,
    this.startTime,
    this.endTime,
    this.description = '',
    this.errorMessage,
  });

  AcademyFormState copyWith({
    bool? isLoading,
    bool? isSaving,
    List<Academy>? academies,
    List<AcademyClass>? classes,
    List<Subject>? subjects,
    List<AcademyTeacher>? teachers,
    List<ChatMember>? members,

    Object? selectedAcademy = _academyFormStateUnset,
    Object? selectedClass = _academyFormStateUnset,
    Object? selectedSubject = _academyFormStateUnset,

    Object? mainTeacher = _academyFormStateUnset,

    List<AcademyTeacher>? selectedCoTeachers,
    List<ChatMember>? selectedMembers,

    Object? educationDate = _academyFormStateUnset,
    Object? startTime = _academyFormStateUnset,
    Object? endTime = _academyFormStateUnset,

    String? description,

    Object? errorMessage = _academyFormStateUnset,
  }) {
    return AcademyFormState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,

      academies: academies ?? this.academies,
      classes: classes ?? this.classes,
      subjects: subjects ?? this.subjects,

      teachers: teachers ?? this.teachers,
      members: members ?? this.members,

      selectedAcademy: identical(
        selectedAcademy,
        _academyFormStateUnset,
      )
          ? this.selectedAcademy
          : selectedAcademy as Academy?,

      selectedClass: identical(
        selectedClass,
        _academyFormStateUnset,
      )
          ? this.selectedClass
          : selectedClass as String?,

      selectedSubject: identical(
        selectedSubject,
        _academyFormStateUnset,
      )
          ? this.selectedSubject
          : selectedSubject as String?,

      mainTeacher: identical(
        mainTeacher,
        _academyFormStateUnset,
      )
          ? this.mainTeacher
          : mainTeacher as AcademyTeacher?,

      selectedCoTeachers:
      selectedCoTeachers ?? this.selectedCoTeachers,

      selectedMembers:
      selectedMembers ?? this.selectedMembers,

      educationDate: identical(
        educationDate,
        _academyFormStateUnset,
      )
          ? this.educationDate
          : educationDate as DateTime?,

      startTime: identical(
        startTime,
        _academyFormStateUnset,
      )
          ? this.startTime
          : startTime as DateTime?,

      endTime: identical(
        endTime,
        _academyFormStateUnset,
      )
          ? this.endTime
          : endTime as DateTime?,

      description: description ?? this.description,

      errorMessage: identical(
        errorMessage,
        _academyFormStateUnset,
      )
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}