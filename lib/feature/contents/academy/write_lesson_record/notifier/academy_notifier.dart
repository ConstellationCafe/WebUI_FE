import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../di/ApiProvider.dart';
import '../api/academy_api.dart';
import '../domain/teacher.dart';
import '../domain/member.dart';
import '../domain/lesson_record.dart';
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
      isLoading: true,
    );

    try {
      final classes = await _api.getClasses(academyId);
      final subjects = await _api.getSubjects(academyId);
      final teachers = await _api.getTeachers(academyId);

      state = state.copyWith(
        isLoading: false,
        classes: classes,
        subjects: subjects,
        teachers: teachers,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectClass(String className) async {
    state = state.copyWith(
      selectedClass: className,
      isLoading: true,
    );

    try {
      final academy = state.selectedAcademy;

      if (academy == null) {
        return;
      }

      final members = await _api.getStudents(
        academy.id,
        className,
      );

      state = state.copyWith(
        isLoading: false,
        members: members,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void selectSubject(String subject) {
    state = state.copyWith(
      selectedSubject: subject,
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
    final selected = [...state.selectedCoTeachers];

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
    final selected = [...state.selectedMembers];

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
      selectedMembers: [...state.members],
    );
  }

  void setEducationDate(DateTime date) {
    print('setEducationDate: $date');

    state = state.copyWith(
      educationDate: date,
    );

    print('현재 state: ${state.educationDate}');
  }

  void setStartTime(DateTime time) {
    state = state.copyWith(
      startTime: time,
    );
  }

  void setEndTime(DateTime time) {
    state = state.copyWith(
      endTime: time,
    );
  }

  void setDescription(String description) {
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
    );

    try {
      final start = state.startTime!;
      final end = state.endTime!;

      final duration = end.difference(start);

      final record = LessonRecord(
        academyId: state.selectedAcademy!.id,
        className: state.selectedClass!,
        subject: state.selectedSubject!,
        educationDate: state.educationDate!,
        educationDuration: duration,
        mainTeacherId: state.mainTeacher!.id,
        coTeacherIds: state.selectedCoTeachers
            .map((teacher) => teacher.id)
            .toList(),
        memberIds: state.selectedMembers
            .map((member) => member.id)
            .toList(),
        description: state.description.trim(),
      );

      await _api.createLessonRecord(record);

      state = state.copyWith(
        isSaving: false,
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
    if (state.selectedAcademy == null) {
      return false;
    }

    if (state.selectedClass == null) {
      return false;
    }

    if (state.selectedSubject == null) {
      return false;
    }

    if (state.educationDate == null) {
      return false;
    }

    if (state.startTime == null ||
        state.endTime == null) {
      return false;
    }

    if (state.mainTeacher == null) {
      return false;
    }

    return true;
  }
}