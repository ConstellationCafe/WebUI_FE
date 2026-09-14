import 'package:constellation_cafe/feature/auth/notifier/current_user_state_notifier.dart';
import 'package:constellation_cafe/feature/auth/state/current_user_state.dart';
import 'package:constellation_cafe/feature/modules/academy/domain/model/academy_permission.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/di/ApiProvider.dart';
import '../../data/api/academy_api.dart';
import '../../data/api/lesson_record_api.dart';
import '../../data/repository/lesson_record_repository.dart';
import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/student.dart';
import '../../domain/model/subject.dart';
import '../../domain/model/teacher.dart';
import '../../state/lesson_record_selection_state/lesson_record_selection_state.dart';
import '../permission_notifier/academy_permission_notifier.dart';

part 'lesson_record_selection_notifier.g.dart';

@riverpod
class LessonRecordSelectionNotifier extends _$LessonRecordSelectionNotifier {
  late final LessonRecordRepository repository;
  late final AcademyPermission permission;
  late final CurrentUserState currentUser;

  @override
  LessonRecordSelectionState build() {
    final AcademyApi academyApi = ref.read(academyApiProvider);
    final LessonRecordApi lessonRecordApi = ref.read(lessonRecordApiProvider);
    final permissionState = ref.watch(academyPermissionProvider);
    permission = permissionState.permission!;
    currentUser = ref.read(currentUserStateProvider);
    repository = LessonRecordRepository(
      academyApi: academyApi,
      lessonRecordApi: lessonRecordApi,
    );

    _loadAcademies();

    return LessonRecordSelectionState(
      isLoading: true,
    );
  }

  Future<void> _loadAcademies() async {
    try {
      final List<Academy> academies = await repository.getAcademies();
      final allowedAcademies = permission.isAdmin
        ? academies
        : academies
          .where(
            (academy) => permission.academies.any(
              (permissionAcademy) =>
              permissionAcademy.academyId == academy.id
            )
          ).toList();
      state = state.copyWith(
        isLoading: false,
        queryForm: state.queryForm.copyWith(
          academies: allowedAcademies,
        ),
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectAcademy(Academy academy) async {
    state = state.copyWith(
      isLoading: true,
      queryForm: state.queryForm.copyWith(
        selectedAcademy: academy,
        classes: [],
        students: [],
        subjects: [],
        teachers: [],
        selectedAcademyClass: null,
        selectedSubject: null,
        mainTeacher: null,
        selectedCoTeachers: [],
        selectedStudents: [],
      ),
      errorMessage: null,
    );
    try {
      // 병렬 호출
      final (classes, subjects) = await (
        repository.getClasses(academy.id),
        repository.getSubjects(academy.id),
      ).wait;
      final operatingClasses = classes
          .where((academyClass) => academyClass.state == "운영")
          .toList();
      final allowedClasses = permission.isOwnerWithAcademy(academy.id)
          ? operatingClasses
          : operatingClasses
              .where(
                (academyClass) => permission.isTeacherOrAboveWithClass(
                  academy.id,
                  academyClass.id,
                ),
              )
              .toList();
      state = state.copyWith(
        isLoading: false,
        queryForm: state.queryForm.copyWith(
          classes: allowedClasses,
          subjects: subjects,
        ),
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectClass(AcademyClass selectedAcademyClass) async {
    state = state.copyWith(
      isLoading: true,
      queryForm: state.queryForm.copyWith(
        selectedAcademyClass: selectedAcademyClass,
        students: [],
        selectedStudents: [],
      ),
      errorMessage: null,
    );
    try {
      final Academy selectedAcademy = state.queryForm.selectedAcademy!;
      final (teachers, students) = await (
        repository.getTeachers(selectedAcademy.id),
        repository.getStudents(selectedAcademy.id, selectedAcademyClass.id)
      ).wait;
      final canSelectTeachers = permission.isOwnerWithAcademy(selectedAcademy.id)
          ? teachers
          : teachers
          .where(
            (teacher) =>
              teacher.discordID == currentUser.userId,
          )
          .toList();
      state = state.copyWith(
        isLoading: false,
        queryForm: state.queryForm.copyWith(
          teachers: canSelectTeachers,
          coTeachers: teachers,
          students: students,
        ),
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void selectSubject(Subject selectedSubject) {
    state = state.copyWith(
      queryForm: state.queryForm.copyWith(
        selectedSubject: selectedSubject,
      ),
    );
  }

  void selectMainTeacher(Teacher mainTeacher) {
    state = state.copyWith(
      queryForm: state.queryForm.copyWith(
        mainTeacher: mainTeacher,
      ),
    );
  }

  void toggleCoTeacher(Teacher teacher) {
    final selectedCoTeachers = [
      ...state.queryForm.selectedCoTeachers,
    ];
    final exists = selectedCoTeachers.any(
          (element) => element.sk == teacher.sk,
    );
    if (exists) {
      selectedCoTeachers.removeWhere(
            (element) => element.sk == teacher.sk,
      );
    } else {
      selectedCoTeachers.add(teacher);
    }
    state = state.copyWith(
      queryForm: state.queryForm.copyWith(
        selectedCoTeachers: selectedCoTeachers,
      ),
    );
  }

  void toggleStudent(Student student) {
    final selectedStudents = [
      ...state.queryForm.selectedStudents,
    ];
    final exists = selectedStudents.any(
          (element) => element.sk == student.sk,
    );
    if (exists) {
      selectedStudents.removeWhere(
            (element) => element.sk == student.sk,
      );
    } else {
      selectedStudents.add(student);
    }
    state = state.copyWith(
      queryForm: state.queryForm.copyWith(
        selectedStudents: selectedStudents,
      ),
    );
  }

  void selectAllStudents() {
    state = state.copyWith(
      queryForm: state.queryForm.copyWith(
        selectedStudents: state.queryForm.students,
      ),
    );
  }

  void setEducationDate(DateTime date) {
    state = state.copyWith(
      queryForm: state.queryForm.copyWith(
        educationDate: date,
      ),
    );
  }

  void setStartTime(DateTime time) {
    state = state.copyWith(
      queryForm: state.queryForm.copyWith(
        startTime: time,
      ),
    );
  }

  void setEndTime(DateTime time) {
    state = state.copyWith(
      queryForm: state.queryForm.copyWith(
        endTime: time,
      ),
    );
  }

  Future<void> resetFilters() async {
    state = state.copyWith(
      queryForm: state.queryForm.copyWith(
        selectedAcademy: null,
        selectedAcademyClass: null,
        selectedSubject: null,
        mainTeacher: null,
        selectedCoTeachers: [],
        selectedStudents: [],
        educationDate: null,
        startTime: null,
        endTime: null,
        classes: [],
        students: [],
        subjects: [],
        teachers: [],
      ),
    );
  }
}