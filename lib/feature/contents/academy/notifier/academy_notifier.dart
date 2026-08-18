import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../di/ApiProvider.dart';
import '../api/academy_api.dart';
import '../domain/model/member.dart';
import '../domain/model/lesson_record.dart';
import '../domain/model/teacher.dart';
import '../state/academy_form_state.dart';

part 'academy_notifier.g.dart';

@riverpod
class AcademyNotifier extends _$AcademyNotifier {
  late final AcademyApi _api;

  @override
  AcademyFormState build() {
    _api = ref.watch(academyApiProvider);

    Future.microtask(_initialize);

    return const AcademyFormState(
      isLoading: true,
    );
  }

  Future<void> _initialize() async {
    try {
      final academies = await _api.getAcademies();

      state = state.copyWith(
        isLoading: false,
        academies: academies,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectAcademy(
      String academyId,
      ) async {
    final academy = state.academies.firstWhere(
          (element) => element.id == academyId,
    );

    state = state.copyWith(
      selectedAcademy: academy,
      selectedClass: null,
      selectedSubject: null,
      mainTeacher: null,
      selectedCoTeachers: [],
      selectedMembers: [],
      members: [],
      isLoading: true,
      errorMessage: null,
    );

    try {
      final classes = await _api.getClasses(
        academyId,
      );

      final subjects = await _api.getSubjects(
        academyId,
      );

      final teachers = await _api.getTeachers(
        academyId,
      );

      state = state.copyWith(
        isLoading: false,
        classes: classes,
        subjects: subjects,
        teachers: teachers,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectClass(
      String className,
      ) async {
    final academy = state.selectedAcademy;

    if (academy == null) {
      state = state.copyWith(
        selectedClass: null,
        members: [],
        selectedMembers: [],
        isLoading: false,
        errorMessage: '학원을 먼저 선택해주세요.',
      );
      return;
    }

    state = state.copyWith(
      selectedClass: className,
      selectedMembers: [],
      members: [],
      isLoading: true,
      errorMessage: null,
    );

    try {
      final members = await _api.getStudents(
        academy.id,
        className,
      );

      state = state.copyWith(
        isLoading: false,
        members: members,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void selectSubject(
      String subject,
      ) {
    state = state.copyWith(
      selectedSubject: subject,
      errorMessage: null,
    );
  }

  void selectMainTeacher(
      AcademyTeacher teacher,
      ) {
    state = state.copyWith(
      mainTeacher: teacher,
    );
  }

  void toggleCoTeacher(
      AcademyTeacher teacher,
      ) {
    final selected = [
      ...state.selectedCoTeachers,
    ];

    final exists = selected.any(
          (element) => element.id == teacher.id,
    );

    if (exists) {
      selected.removeWhere(
            (element) => element.id == teacher.id,
      );
    } else {
      selected.add(teacher);
    }

    state = state.copyWith(
      selectedCoTeachers: selected,
    );
  }

  void toggleMember(
      ChatMember member,
      ) {
    final selected = [
      ...state.selectedMembers,
    ];

    final exists = selected.any(
          (element) => element.id == member.id,
    );

    if (exists) {
      selected.removeWhere(
            (element) => element.id == member.id,
      );
    } else {
      selected.add(member);
    }

    state = state.copyWith(
      selectedMembers: selected,
    );
  }

  void selectAllMembers() {
    state = state.copyWith(
      selectedMembers: [
        ...state.members,
      ],
    );
  }

  void setEducationDate(
      DateTime date,
      ) {
    state = state.copyWith(
      educationDate: date,
    );
  }

  void setStartTime(
      DateTime time,
      ) {
    state = state.copyWith(
      startTime: time,
    );
  }

  void setEndTime(
      DateTime time,
      ) {
    state = state.copyWith(
      endTime: time,
    );
  }

  void setDescription(
      String description,
      ) {
    state = state.copyWith(
      description: description,
    );
  }

  Future<bool> saveLessonRecord() async {
    if (!_validate()) {
      return false;
    }

    state = state.copyWith(
      isSaving: true,
      errorMessage: null,
    );

    try {
      final selectedAcademy = state.selectedAcademy;
      final selectedClass = state.selectedClass;
      final selectedSubject = state.selectedSubject;
      final educationDate = state.educationDate;
      final startTime = state.startTime;
      final endTime = state.endTime;
      final mainTeacher = state.mainTeacher;

      if (selectedAcademy == null ||
          selectedClass == null ||
          selectedSubject == null ||
          educationDate == null ||
          startTime == null ||
          endTime == null ||
          mainTeacher == null) {
        state = state.copyWith(
          isSaving: false,
        );

        return false;
      }

      final duration = endTime.difference(
        startTime,
      );

      final record = LessonRecord(
        academyId: selectedAcademy.id,
        className: selectedClass,
        subject: selectedSubject,
        educationDate: educationDate,
        educationDuration: duration,
        mainTeacherId: mainTeacher.id,
        coTeacherIds: state.selectedCoTeachers
            .map(
              (teacher) => teacher.id,
        )
            .toList(),
        memberIds: state.selectedMembers
            .map(
              (member) => member.id,
        )
            .toList(),
        description: state.description.trim(),
      );

      await _api.createLessonRecord(
        record,
      );

      state = state.copyWith(
        isSaving: false,
        errorMessage: null,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: e.toString(),
      );

      return false;
    }
  }

  bool _validate() {
    final selectedAcademy = state.selectedAcademy;
    final selectedClass = state.selectedClass;
    final selectedSubject = state.selectedSubject;
    final educationDate = state.educationDate;
    final startTime = state.startTime;
    final endTime = state.endTime;
    final mainTeacher = state.mainTeacher;

    if (selectedAcademy == null) {
      return false;
    }

    if (selectedClass == null) {
      return false;
    }

    if (selectedSubject == null) {
      return false;
    }

    if (educationDate == null) {
      return false;
    }

    if (startTime == null ||
        endTime == null) {
      return false;
    }

    if (mainTeacher == null) {
      return false;
    }

    if (!endTime.isAfter(startTime)) {
      return false;
    }

    return true;
  }
}