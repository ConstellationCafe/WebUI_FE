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
import '../../state/lesson_record_query_state/lesson_record_query_state.dart';

part 'lesson_record_query_notifier.g.dart';

@riverpod
class LessonRecordQueryNotifier
    extends _$LessonRecordQueryNotifier {
  late final LessonRecordRepository repository;

  @override
  LessonRecordQueryState build() {
    final AcademyApi academyApi =
    ref.read(academyApiProvider);

    final LessonRecordApi lessonRecordApi =
    ref.read(lessonRecordApiProvider);

    repository = LessonRecordRepository(
      academyApi: academyApi,
      lessonRecordApi: lessonRecordApi,
    );

    _loadAcademies();

    return LessonRecordQueryState(
      isLoading: true,
    );
  }

  Future<void> _loadAcademies() async {
    try {
      final List<Academy> academies =
      await repository.getAcademies();

      state = state.copyWith(
        isLoading: false,
        queryForm: state.queryForm.copyWith(
          academies: academies,
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
      final List<AcademyClass> classes =
      await repository.getClasses(academy.id);

      final List<Subject> subjects =
      await repository.getSubjects(academy.id);

      final List<Teacher> teachers =
      await repository.getTeachers(academy.id);

      state = state.copyWith(
        isLoading: false,
        queryForm: state.queryForm.copyWith(
          classes: classes,
          subjects: subjects,
          teachers: teachers,
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

  Future<void> selectClass(
      AcademyClass selectedAcademyClass,
      ) async {
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

      final List<Student> students =
      await repository.getStudents(
        selectedAcademy.id,
        selectedAcademyClass.id,
      );

      state = state.copyWith(
        isLoading: false,
        queryForm: state.queryForm.copyWith(
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