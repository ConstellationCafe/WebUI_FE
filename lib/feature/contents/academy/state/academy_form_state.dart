import '../domain/model/academy.dart';
import '../domain/model/academy_class.dart';
import '../domain/model/subject.dart';
import '../domain/model/teacher.dart';
import '../domain/model/member.dart';

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
    Academy? selectedAcademy,
    String? selectedClass,
    String? selectedSubject,
    AcademyTeacher? mainTeacher,
    List<AcademyTeacher>? selectedCoTeachers,
    List<ChatMember>? selectedMembers,
    DateTime? educationDate,
    DateTime? startTime,
    DateTime? endTime,
    String? description,
    String? errorMessage,
  }) {
    return AcademyFormState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      academies: academies ?? this.academies,
      classes: classes ?? this.classes,
      subjects: subjects ?? this.subjects,
      teachers: teachers ?? this.teachers,
      members: members ?? this.members,
      selectedAcademy: selectedAcademy ?? this.selectedAcademy,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedSubject: selectedSubject ?? this.selectedSubject,
      mainTeacher: mainTeacher ?? this.mainTeacher,
      selectedCoTeachers:
      selectedCoTeachers ?? this.selectedCoTeachers,
      selectedMembers:
      selectedMembers ?? this.selectedMembers,
      educationDate:
      educationDate ?? this.educationDate,
      startTime:
      startTime ?? this.startTime,
      endTime:
      endTime ?? this.endTime,
      description:
      description ?? this.description,
      errorMessage:
      errorMessage ?? this.errorMessage,
    );
  }
}