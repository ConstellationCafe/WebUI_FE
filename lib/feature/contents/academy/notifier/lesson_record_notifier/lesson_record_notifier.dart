import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:constellation_cafe/di/ApiProvider.dart';
import '../../data/api/academy_api.dart';
import '../../data/api/lesson_record_api.dart';
import '../../domain/model/academy.dart';
import '../../domain/model/academy_class.dart';
import '../../domain/model/lesson_record_form/lesson_record_form.dart';
import '../../domain/model/student.dart';
import '../../domain/model/lesson_record.dart';
import '../../domain/model/subject.dart';
import '../../domain/model/teacher.dart';
import '../../state/lesson_record_form_state/lesson_record_form_state.dart';

part 'lesson_record_notifier.g.dart';

@riverpod
class LessonRecordNotifier extends _$LessonRecordNotifier {
  late final AcademyApi academyApi;
  late final LessonRecordApi lessonRecordApi;

  @override
  LessonRecordFormState build() {
    academyApi = ref.read(academyApiProvider);
    lessonRecordApi = ref.read(lessonRecordApiProvider);
    _loadAcademies();
    return LessonRecordFormState(
      isLoading: true,
    );
  }

  Future<void> _loadAcademies() async {
    try {
      List<Academy> academies = await academyApi.getAcademies();
      state = state.copyWith(
        isLoading: false,
        lessonRecordForm: state.lessonRecordForm.copyWith(
            academies: academies
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
      lessonRecordForm: state.lessonRecordForm.copyWith(
        selectedAcademy: academy,
        classes: [],
        students: [],
        selectedAcademyClass: null,
        selectedSubject: null,
        mainTeacher: null,
        selectedCoTeachers: [],
        selectedStudents: [],
      ),
      errorMessage: null,
    );
    try {
      List<AcademyClass> classes = await academyApi.getClasses(academy.id);
      List<Subject> subjects = await academyApi.getSubjects(academy.id);
      List<Teacher> teachers = await academyApi.getTeachers(academy.id);
      state = state.copyWith(
        isLoading: false,
        lessonRecordForm: state.lessonRecordForm.copyWith(
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

  Future<void> selectClass(AcademyClass selectedAcademyClass) async {
    state = state.copyWith(
      isLoading: true,
      lessonRecordForm: state.lessonRecordForm.copyWith(
        selectedAcademyClass: selectedAcademyClass
      ),
      errorMessage: null,
    );
    try {
      Academy selectedAcademy = state.lessonRecordForm.selectedAcademy;
      List<Student> students = await academyApi.getStudents(
          selectedAcademy.id,
          selectedAcademyClass.classNumber
      );
      state = state.copyWith(
        isLoading: false,
        lessonRecordForm: state.lessonRecordForm.copyWith(
            students: students
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
      lessonRecordForm: state.lessonRecordForm.copyWith(
          selectedSubject: selectedSubject
      ),
    );
  }

  void selectMainTeacher(Teacher mainTeacher) {
    state = state.copyWith(
      lessonRecordForm: state.lessonRecordForm.copyWith(
          mainTeacher: mainTeacher
      ),
    );
  }

  void toggleCoTeacher(Teacher teacher) {
    final selectedCoTeachers = [
      ...state.lessonRecordForm.selectedCoTeachers,
    ];
    final exists = selectedCoTeachers.any(
          (element) => element.id == teacher.id,
    );
    if (exists) {
      selectedCoTeachers.removeWhere(
            (element) => element.id == teacher.id,
      );
    } else {
      selectedCoTeachers.add(teacher);
    }
    state = state.copyWith(
      lessonRecordForm: state.lessonRecordForm.copyWith(
          selectedCoTeachers: selectedCoTeachers
      ),
    );
  }

  void toggleStudent(Student student) {
    final selectedStudents = [
      ...state.lessonRecordForm.selecteStudentss,
    ];

    final exists = selectedStudents.any(
          (element) => element.id == student.id,
    );

    if (exists) {
      selectedStudents.removeWhere(
            (element) => element.id == student.id,
      );
    } else {
      selectedStudents.add(student);
    }

    state = state.copyWith(
      lessonRecordForm: state.lessonRecordForm.copyWith(
        selectedStudents: selectedStudents
      ),
    );
  }

  void selectAllStudents() {
    state = state.copyWith(
      lessonRecordForm: state.lessonRecordForm.copyWith(
        selectedStudents: state.lessonRecordForm.students,
      ),
    );
  }

  void setEducationDate(DateTime date) {
    state = state.copyWith(
      lessonRecordForm: state.lessonRecordForm.copyWith(
        educationDate: date,
      ),
    );
  }

  void setStartTime(DateTime time) {
    state = state.copyWith(
      lessonRecordForm: state.lessonRecordForm.copyWith(
        startTime: time,
      ),
    );
  }

  void setEndTime(DateTime time) {
    state = state.copyWith(
      lessonRecordForm: state.lessonRecordForm.copyWith(
        endTime: time,
      ),
    );
  }

  void setDescription(String description) {
    state = state.copyWith(
      lessonRecordForm: state.lessonRecordForm.copyWith(
        description: description,
      ),
    );
  }

  Future<bool> saveLessonRecord() async {
    if (!_stateValidate()) {
      return false;
    }
    state = state.copyWith(
      isSaving: true,
      errorMessage: null,
    );
    try {
      LessonRecordForm lessonRecordForm = state.lessonRecordForm;
      final selectedAcademy = lessonRecordForm.selectedAcademy!;
      final selectedAcademyClass = lessonRecordForm.selectedAcademyClass!;
      final selectedSubject = lessonRecordForm.selectedSubject!;
      final educationDate = lessonRecordForm.educationDate!;
      final startTime = lessonRecordForm.startTime!;
      final endTime = lessonRecordForm.endTime!;
      final mainTeacher = lessonRecordForm.mainTeacher!;

      final duration = endTime.difference(startTime);
      final record = LessonRecord(
        academyId: selectedAcademy.id,
        className: selectedAcademyClass.classNumber,
        subject: selectedSubject.name,
        educationDate: educationDate,
        educationDuration: duration,
        mainTeacherId: mainTeacher.id,
        coTeacherIds: lessonRecordForm.selectedCoTeachers
            .map((teacher) => teacher.id)
            .toList(),
        memberIds: lessonRecordForm.selectedStudents
            .map((member) => member.id)
            .toList(),
        description: lessonRecordForm.description.trim(),
      );

      await lessonRecordApi.createLessonRecord(record);
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

  bool _stateValidate() {
    LessonRecordForm lessonRecordForm = state.lessonRecordForm;
    final selectedAcademy = lessonRecordForm.selectedAcademy;
    final selectedClass = lessonRecordForm.selectedAcademyClass;
    final selectedSubject = lessonRecordForm.selectedSubject;
    final educationDate = lessonRecordForm.educationDate;
    final startTime = lessonRecordForm.startTime;
    final endTime = lessonRecordForm.endTime;
    final mainTeacher = lessonRecordForm.mainTeacher;

    if (selectedAcademy == null) return false;
    else if (selectedClass == null) return false;
    else if (selectedSubject == null) return false;
    else if (educationDate == null) return false;
    else if (startTime == null || endTime == null) return false;
    else if (mainTeacher == null) return false;
    else if (!endTime.isAfter(startTime)) return false;
    else return true;
  }
}
